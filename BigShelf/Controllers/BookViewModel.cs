using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BigShelf.Models;

namespace BigShelf.Controllers
{
	public class BookViewModel
	{
		public BookViewModel()
		{
			Book = new Book();
			FlaggedBook = new FlaggedBook();
		}

		public BookViewModel(Book book, IEnumerable<FlaggedBook> flaggedBooksForUser)
		{
			Book = book;
			FlaggedBook = flaggedBooksForUser.FirstOrDefault(b => b.BookId == book.Id);
		}

		private Book Book
		{
			get;
			set;
		}

		private FlaggedBook FlaggedBook
		{
			get;
			set;
		}

		public int Id
		{
			get
			{
				return Book.Id;
			}
			set
			{
				Book.Id = value;
			}
		}

		public string Title
		{
			get
			{
				return Book.Title;
			}
		}

		public string Author
		{
			get
			{
				return Book.Author;
			}
		}

		public string CoverImageUrl
		{
			get
			{
				return "http://images.amazon.com/images/P/" + Book.ASIN + ".01.TZZ.jpg";
			}
		}

		public int Rating
		{
			get
			{
				return FlaggedBook != null ? FlaggedBook.Rating : 0;
			}
			set
			{
				FlaggedBook.Rating = value;
			}
		}

		public bool IsFlaggedToRead
		{
			get
			{
				return FlaggedBook != null ? FlaggedBook.IsFlaggedToRead != 0 : false;
			}
		}

		public bool CanFlagToRead
		{
			get
			{
				return Rating == 0 && !IsFlaggedToRead;
			}
		}

		public string StatusText
		{
			get
			{
				if (Rating > 0) return "Done reading";
				return IsFlaggedToRead ? "Might read it" : "Save";
			}
		}
	}
}