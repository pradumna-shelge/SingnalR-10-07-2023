namespace BackEnd.DTOs
{
    public class GroupCreateDto
    {
        public int CreatedBy { get; set; }
        public string GroupName { get; set; }
         public string imageUrl { get; set; }
        public IEnumerable<int> members { get; set; }

    }
}
