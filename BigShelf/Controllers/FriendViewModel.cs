using BigShelf.Models;

namespace BigShelf.Controllers
{
	public class FriendViewModel
	{
		public FriendViewModel(Friend friend)
		{
			Friend = friend;
		}

		private Friend Friend
		{
			get;
			set;
		}

		public int Id
		{
			get
			{
				return Friend.FriendId;
			}
		}

		public string Name
		{
			get
			{
				return Friend.FriendProfile.Name;
			}
		}

		public bool Checked
		{
			get;
			set;
		}
	}
}