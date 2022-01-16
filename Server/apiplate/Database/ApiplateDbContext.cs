using apiplate.Domain.Models;
using apiplate.Helpers;
using Microsoft.EntityFrameworkCore;

namespace apiplate.DataBase{
    public class ApiplateDbContext : DbContext{
        
        public ApiplateDbContext(DbContextOptions options) : base(options) {

        }
         protected override void OnModelCreating(ModelBuilder builder)
        {
            builder.Entity<Admin>().HasIndex(c => c.Email).IsUnique();
            builder.Entity<Admin>().Property(c => c.Email).IsRequired();
            builder.Entity<Customer>().HasIndex(c => c.Phone).IsUnique();
            builder.Entity<DeliveryDriver>().HasIndex(c => c.Phone).IsUnique();
            builder.Entity<Admin>().HasData(GetManagerUser());
            builder.Entity<Role>().HasIndex(c => c.Title).IsUnique();

        }
        private Admin GetManagerUser()
        {
            byte[] pHash, pSalt;
            HashingHelper.CreateHashPassword("maze@0099", out pHash, out pSalt);
            Admin admin = new Admin()
            {
                Id = 1,
                Username = "almunzir99",
                PasswordHash = pHash,
                PasswordSalt = pSalt,
                Phone = "249128647019",
                Email= "almunzir99@gmail.com",
                IsManager = true,
                CreatedAt = System.DateTime.Now,
                LastUpdate = System.DateTime.Now

                
            };
            return admin;

        }
            public DbSet<Admin> Users { get; set; }
            public DbSet<Message> Messages { get; set; }
            public DbSet<Role> Roles { get; set; }
            public DbSet<Permission> Permissions { get; set; }
            public DbSet<Customer> Customers { get; set; }
            public DbSet<DeliveryDriver> DeliveryDrivers { get; set; }
            public DbSet<Category> Categories { get; set; }
            public DbSet<Product> Products { get; set; }
            public DbSet<Option> Options { get; set; }
            public DbSet<AddOn> Addons { get; set; }
            public DbSet<OptionValue> OptionValues { get; set; }
            public DbSet<Branch> Branches { get; set; }


            







            
    }
}