using System.ComponentModel.DataAnnotations;

namespace apiplate.Resources
{
    public class BaseContentResource : BaseResource
    {
         
            [Required]
            [MaxLength(75)]
            public string Title { get; set; }
            [Required]
            [MaxLength(75)]
            public string ArTitle { get; set; }
            [Required]
            [MaxLength(100)]
            public string Subtitle { get; set; }
            [Required]
            [MaxLength(100)]
            public string ArSubtitle { get; set; }
            [Required]
            [MaxLength(200)]
            public string Description { get; set; }
            [MaxLength(200)]
            [Required]
            public string ArDescription { get; set; }
            [Required]
            public string Content { get; set; }
            [Required]
            public string ArContent { get; set; }
            public string ImagePath { get; set; }
        }
    
}