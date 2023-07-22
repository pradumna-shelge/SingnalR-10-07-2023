namespace BackEnd.DTOs
{
    public class ChatMessageDto
    {
 
        public int ConversationId { get; set; }
        public int Author { get; set; }
        public int Receiver { get; set; }
        public bool isGroup { get; set; }
        
        public string group { get; set; }

        public string Content { get; set; }
        public DateTime Timestamp { get; set; }

        
    }

}
