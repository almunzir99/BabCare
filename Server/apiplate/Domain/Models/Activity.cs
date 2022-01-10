namespace apiplate.Domain.Models
{
    public class Activity
    {
        public int Id { get; set; }

        public int UserId { get; set; }
        public string  EffectedTable { get; set; }
        public int EffectedRowId { get; set; }
        public string Action { get; set; }
        public System.DateTime  CreatedAt { get; set; }
        public Activity(){}
        public Activity(int userId, string effectedTable, int effectedRowId, string action, System.DateTime createdAt)
        {
            UserId = userId;
            EffectedTable = effectedTable;
            EffectedRowId = effectedRowId;
            Action = action;
            CreatedAt = createdAt;
        }
    }
}