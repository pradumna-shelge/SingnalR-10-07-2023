using System;
using System.Collections.Generic;

namespace BackEnd.Models;

public partial class Group
{
    public int Id { get; set; }

    public string? GroupName { get; set; }

    public int? CreatedBy { get; set; }

    public string? ImageUrl { get; set; }

    public virtual ICollection<Conversation> Conversations { get; set; } = new List<Conversation>();

    public virtual User? CreatedByNavigation { get; set; }

    public virtual ICollection<GroupMember> GroupMembers { get; set; } = new List<GroupMember>();
}
