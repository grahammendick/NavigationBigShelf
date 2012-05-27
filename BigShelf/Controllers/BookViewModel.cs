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
		}

		public BookViewModel(Book book)
		{
			Book = book;
		}

		private Book Book
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
	}
}