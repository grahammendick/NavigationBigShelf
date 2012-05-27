using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.ModelBinding;
using BigShelf.Models;
using Navigation;

namespace BigShelf.Controllers
{
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

		public IEnumerable<Book> GetBooksForSearch(
			[NavigationData] Sort sort,
			[NavigationData] bool sortAscending,
			[NavigationData] int page,
			[NavigationData] int pageSize)
		{
			IQueryable<Book> booksQuery = this.DbContext.Books;
			return this.ApplyOrderBy(booksQuery, sort, sortAscending).Skip((page - 1) * pageSize).Take(pageSize).ToList();
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
			return new BookViewModel(DbContext.Books.Single(b => b.Id == id));
		}
	}
}