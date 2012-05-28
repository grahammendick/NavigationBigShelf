using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.ModelBinding;
using BigShelf.Models;
using Navigation;

namespace BigShelf.Controllers
{
	public enum Filter
	{
		All,
		Mine,
		Friends
	}

	public enum Sort
	{
		None,
		Title,
		Author,
		Rating,
		MightRead
	}

	public class BigShelfController
	{
		private BigShelfEntities DbContext = new BigShelfEntities();
		private int TotalItems = 0;
		private IEnumerable<FlaggedBook> FlaggedBooksForUser;

		public IEnumerable<Book> GetBooksForSearch(
			[NavigationData] Filter filter,
			[NavigationData] Sort sort,
			[NavigationData] string title,
			[NavigationData] bool sortAscending,
			[NavigationData] int page,
			[NavigationData] int pageSize)
		{
			IQueryable<Book> booksQuery = this.DbContext.Books;
			booksQuery = this.ApplyFilter(booksQuery, filter);
			if (title != null)
				booksQuery = booksQuery.Where(p => p.Title.Contains(title));
			TotalItems = booksQuery.Count();
			return this.ApplyOrderBy(booksQuery, sort, sortAscending).Skip((page - 1) * pageSize).Take(pageSize).ToList();
		}

		private IQueryable<Book> ApplyFilter(IQueryable<Book> booksQuery, Filter filter)
		{
			switch (filter)
			{
				case Filter.Mine:
					return booksQuery.Where(p => p.FlaggedBooks.Any(q => q.ProfileId == 1));
				case Filter.Friends:
					return booksQuery;
				default:
					return booksQuery;
			}
		}

		private IQueryable<Book> ApplyOrderBy(IQueryable<Book> booksQuery, Sort sort, bool sortAscending)
		{
			switch (sort)
			{
				case Sort.Title:
					return sortAscending ? booksQuery.OrderBy(book => book.Title) : booksQuery.OrderByDescending(book => book.Title);
				case Sort.Author:
					return sortAscending ? booksQuery.OrderBy(book => book.Author) : booksQuery.OrderByDescending(book => book.Author);
				case Sort.Rating:
				case Sort.MightRead:
					int flaggedBookWeight = sort == Sort.Rating ? 0 : 6;
					int authenticatedProfileId = 1;

					return
						from book in booksQuery
						let flaggedBook = book.FlaggedBooks.Where(p => p.ProfileId == authenticatedProfileId).FirstOrDefault()
						let weighting = flaggedBook == null ? -1 : (flaggedBook.IsFlaggedToRead != 0 ? flaggedBookWeight : flaggedBook.Rating)
						orderby sortAscending ? weighting : -weighting
						select book;
				case Sort.None:
				default:
					return booksQuery;
			}
		}

		public BookViewModel GetBook([Control] int id)
		{
			return new BookViewModel(DbContext.Books.Single(b => b.Id == id), GetFlaggedBooksForUser());
		}

		public void UpdateBook(BookViewModel bookViewModel)
		{
			FlaggedBook flaggedBook = this.GetFlaggedBooksForUser().FirstOrDefault(b => b.BookId == bookViewModel.Id);
			if (flaggedBook == null)
			{
				flaggedBook = new FlaggedBook();
				flaggedBook.ProfileId = 1;
				flaggedBook.BookId = bookViewModel.Id;
				flaggedBook.Rating = bookViewModel.Rating;
				flaggedBook.IsFlaggedToRead = bookViewModel.Rating == 0 ? 1 : 0;
				DbContext.FlaggedBooks.Add(flaggedBook);
			}
			else
			{
				flaggedBook.Rating = bookViewModel.Rating;
				flaggedBook.IsFlaggedToRead = bookViewModel.Rating == 0 ? 1 : 0;
			}
			DbContext.SaveChanges();
			FlaggedBooksForUser = null;
		}

		public void RateBook(BookViewModel bookViewModel)
		{
			if (bookViewModel.Rating != 0)
				UpdateBook(bookViewModel);
		}

		public IEnumerable<FlaggedBook> GetFlaggedBooksForUser()
		{
			if (FlaggedBooksForUser == null)
			{
				int authenticatedProfileId = 1;
				FlaggedBooksForUser = this.DbContext.FlaggedBooks.Where(f => f.ProfileId == authenticatedProfileId).ToList();
			}
			return FlaggedBooksForUser;
		}

		public IEnumerable<PagingViewModel> GetPages(
			[NavigationData] Filter filter,
			[NavigationData] string title,
			[NavigationData] int page,
			[NavigationData] int pageSize)
		{
			if (TotalItems == 0) yield break;
			for (int firstOnPage = 1, index = 1; firstOnPage <= TotalItems; firstOnPage += pageSize, index++)
			{
				int lastOnPage = Math.Min(firstOnPage + pageSize - 1, TotalItems);
				yield return new PagingViewModel()
				{
					Index = index,
					GroupText = firstOnPage + "-" + lastOnPage
				};
			}
		}

		public IEnumerable<SortViewModel> GetSortOptions([NavigationData] Sort sort)
		{
			yield return new SortViewModel() { Text = "Title", Sort = "Title", Ascending = true };
			yield return new SortViewModel() { Text = "Author", Sort = "Author", Ascending = true };
			yield return new SortViewModel() { Text = "Rating", Sort = "Rating" };
			yield return new SortViewModel() { Text = "Might Read", Sort = "MightRead" };
		}

		public IEnumerable<FilterViewModel> GetFilterOptions([NavigationData] Filter filter)
		{
			yield return new FilterViewModel() { Text = "All", Filter = "All" };
			yield return new FilterViewModel() { Text = "My books", Filter = "Mine" };
			yield return new FilterViewModel() { Text = "Just friends", Filter = "Friends" };
		}

		public FilterViewModel GetSearch([NavigationData] string title)
		{
			return new FilterViewModel() { Title = title };
		}

		public void SetSearch(FilterViewModel search)
		{
			StateContext.Bag.title = search.Title;
			StateContext.Bag.page = null;
		}

		public IEnumerable<KeyValuePair<string, string>> GetRatings()
		{
			yield return new KeyValuePair<string, string>("0", "");
			yield return new KeyValuePair<string, string>("1", "");
			yield return new KeyValuePair<string, string>("2", "");
			yield return new KeyValuePair<string, string>("3", "");
			yield return new KeyValuePair<string, string>("4", "");
			yield return new KeyValuePair<string, string>("5", "");
		}
	}
}