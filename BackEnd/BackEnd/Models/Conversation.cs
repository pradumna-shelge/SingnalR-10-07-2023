using System;
using System.Collections.Generic;

namespace BackEnd.Models;

public partial class Conversation
{
    public int Id { get; set; }

    public int User1 { get; set; }

    public int User2 { get; set; }

    public virtual ICollection<Message> Messages { get; set; } = new List<Message>();

    public virtual User User1Navigation { get; set; } = null!;

    public virtual User User2Navigation { get; set; } = null!;
}
