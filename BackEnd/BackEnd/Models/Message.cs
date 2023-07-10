using System;
using System.Collections.Generic;

namespace BackEnd.Models;

public partial class Message
{
    public int Id { get; set; }

    public int ConversationId { get; set; }

    public int Author { get; set; }

    public string Content { get; set; } = null!;

    public DateTime Timestamp { get; set; }


    

    public virtual User AuthorNavigation { get;  } = null!;

    public virtual Conversation Conversation { get; } = null!;
}
