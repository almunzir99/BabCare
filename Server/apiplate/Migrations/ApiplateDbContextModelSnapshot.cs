﻿// <auto-generated />
using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using apiplate.DataBase;

namespace apiplate.Migrations
{
    [DbContext(typeof(ApiplateDbContext))]
    partial class ApiplateDbContextModelSnapshot : ModelSnapshot
    {
        protected override void BuildModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("Relational:MaxIdentifierLength", 128)
                .HasAnnotation("ProductVersion", "5.0.5")
                .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

            modelBuilder.Entity("apiplate.Domain.Models.Activity", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<string>("Action")
                        .HasColumnType("nvarchar(max)");

                    b.Property<int?>("AdminId")
                        .HasColumnType("int");

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<int>("EffectedRowId")
                        .HasColumnType("int");

                    b.Property<string>("EffectedTable")
                        .HasColumnType("nvarchar(max)");

                    b.Property<int>("UserId")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.HasIndex("AdminId");

                    b.ToTable("Activity");
                });

            modelBuilder.Entity("apiplate.Domain.Models.Admin", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<int?>("CreatedBy")
                        .HasColumnType("int");

                    b.Property<string>("Email")
                        .IsRequired()
                        .HasColumnType("nvarchar(450)");

                    b.Property<string>("Image")
                        .HasColumnType("nvarchar(max)");

                    b.Property<bool>("IsManager")
                        .HasColumnType("bit");

                    b.Property<DateTime>("LastUpdate")
                        .HasColumnType("datetime2");

                    b.Property<byte[]>("PasswordHash")
                        .IsRequired()
                        .HasColumnType("varbinary(max)");

                    b.Property<byte[]>("PasswordSalt")
                        .IsRequired()
                        .HasColumnType("varbinary(max)");

                    b.Property<string>("Phone")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Photo")
                        .HasColumnType("nvarchar(max)");

                    b.Property<int?>("RoleId")
                        .HasColumnType("int");

                    b.Property<string>("Username")
                        .IsRequired()
                        .HasMaxLength(30)
                        .HasColumnType("nvarchar(30)");

                    b.HasKey("Id");

                    b.HasIndex("Email")
                        .IsUnique();

                    b.HasIndex("RoleId");

                    b.ToTable("Users");

                    b.HasData(
                        new
                        {
                            Id = 1,
                            CreatedAt = new DateTime(2022, 1, 11, 20, 31, 54, 289, DateTimeKind.Local).AddTicks(5),
                            Email = "almunzir99@gmail.com",
                            IsManager = true,
                            LastUpdate = new DateTime(2022, 1, 11, 20, 31, 54, 290, DateTimeKind.Local).AddTicks(1519),
                            PasswordHash = new byte[] { 114, 208, 197, 86, 227, 34, 151, 78, 183, 73, 230, 106, 86, 150, 195, 174, 53, 30, 166, 236, 110, 41, 17, 141, 230, 52, 28, 229, 153, 14, 7, 12, 43, 140, 61, 114, 115, 249, 119, 74, 106, 254, 77, 15, 53, 168, 133, 224, 27, 99, 24, 164, 94, 37, 161, 17, 48, 74, 185, 55, 242, 26, 197, 77 },
                            PasswordSalt = new byte[] { 0, 160, 94, 6, 75, 119, 195, 42, 67, 196, 169, 139, 42, 68, 35, 24, 75, 131, 10, 228, 118, 169, 15, 194, 196, 234, 184, 174, 138, 38, 147, 151, 165, 217, 249, 116, 25, 25, 0, 73, 230, 108, 49, 249, 5, 214, 18, 27, 122, 71, 240, 232, 220, 143, 163, 57, 78, 240, 204, 235, 163, 103, 81, 191, 2, 244, 248, 169, 116, 220, 174, 109, 176, 143, 237, 50, 7, 113, 56, 20, 220, 88, 128, 12, 69, 50, 240, 60, 99, 191, 27, 105, 181, 12, 180, 2, 176, 64, 26, 188, 104, 204, 84, 176, 5, 40, 68, 28, 206, 223, 109, 155, 213, 41, 24, 246, 206, 199, 207, 33, 6, 243, 84, 79, 67, 5, 95, 181 },
                            Phone = "249128647019",
                            Username = "almunzir99"
                        });
                });

            modelBuilder.Entity("apiplate.Domain.Models.Customer", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<int?>("CreatedBy")
                        .HasColumnType("int");

                    b.Property<string>("Email")
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime>("LastUpdate")
                        .HasColumnType("datetime2");

                    b.Property<string>("Location")
                        .HasColumnType("nvarchar(max)");

                    b.Property<byte[]>("PasswordHash")
                        .IsRequired()
                        .HasColumnType("varbinary(max)");

                    b.Property<byte[]>("PasswordSalt")
                        .IsRequired()
                        .HasColumnType("varbinary(max)");

                    b.Property<string>("Phone")
                        .IsRequired()
                        .HasColumnType("nvarchar(450)");

                    b.Property<string>("Photo")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Username")
                        .IsRequired()
                        .HasMaxLength(30)
                        .HasColumnType("nvarchar(30)");

                    b.HasKey("Id");

                    b.HasIndex("Phone")
                        .IsUnique();

                    b.ToTable("Customers");
                });

            modelBuilder.Entity("apiplate.Domain.Models.DeliveryDriver", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<int?>("CreatedBy")
                        .HasColumnType("int");

                    b.Property<string>("Email")
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime>("LastUpdate")
                        .HasColumnType("datetime2");

                    b.Property<byte[]>("PasswordHash")
                        .IsRequired()
                        .HasColumnType("varbinary(max)");

                    b.Property<byte[]>("PasswordSalt")
                        .IsRequired()
                        .HasColumnType("varbinary(max)");

                    b.Property<string>("Phone")
                        .IsRequired()
                        .HasColumnType("nvarchar(450)");

                    b.Property<string>("Photo")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Username")
                        .IsRequired()
                        .HasMaxLength(30)
                        .HasColumnType("nvarchar(30)");

                    b.HasKey("Id");

                    b.HasIndex("Phone")
                        .IsUnique();

                    b.ToTable("DeliveryDrivers");
                });

            modelBuilder.Entity("apiplate.Domain.Models.Message", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<string>("Content")
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<int?>("CreatedBy")
                        .HasColumnType("int");

                    b.Property<string>("Email")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("FullName")
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime>("LastUpdate")
                        .HasColumnType("datetime2");

                    b.Property<string>("Phone")
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.ToTable("Messages");
                });

            modelBuilder.Entity("apiplate.Domain.Models.Notification", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<string>("Action")
                        .HasColumnType("nvarchar(max)");

                    b.Property<int?>("AdminId")
                        .HasColumnType("int");

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<int?>("CreatedBy")
                        .HasColumnType("int");

                    b.Property<int?>("CustomerId")
                        .HasColumnType("int");

                    b.Property<int?>("DeliveryDriverId")
                        .HasColumnType("int");

                    b.Property<int?>("GroupedItem")
                        .HasColumnType("int");

                    b.Property<DateTime>("LastUpdate")
                        .HasColumnType("datetime2");

                    b.Property<string>("Message")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Module")
                        .HasColumnType("nvarchar(max)");

                    b.Property<bool>("Read")
                        .HasColumnType("bit");

                    b.Property<string>("Title")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Url")
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.HasIndex("AdminId");

                    b.HasIndex("CustomerId");

                    b.HasIndex("DeliveryDriverId");

                    b.ToTable("Notification");
                });

            modelBuilder.Entity("apiplate.Domain.Models.Permission", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<bool>("Create")
                        .HasColumnType("bit");

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<int?>("CreatedBy")
                        .HasColumnType("int");

                    b.Property<bool>("Delete")
                        .HasColumnType("bit");

                    b.Property<DateTime>("LastUpdate")
                        .HasColumnType("datetime2");

                    b.Property<bool>("Read")
                        .HasColumnType("bit");

                    b.Property<bool>("Update")
                        .HasColumnType("bit");

                    b.HasKey("Id");

                    b.ToTable("Permissions");
                });

            modelBuilder.Entity("apiplate.Domain.Models.Role", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<int?>("AdminsPermissionsId")
                        .HasColumnType("int");

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<int?>("CreatedBy")
                        .HasColumnType("int");

                    b.Property<int?>("CustomersPermissionsId")
                        .HasColumnType("int");

                    b.Property<int?>("DeliveryPermissionsId")
                        .HasColumnType("int");

                    b.Property<DateTime>("LastUpdate")
                        .HasColumnType("datetime2");

                    b.Property<int?>("MessagesPermissionsId")
                        .HasColumnType("int");

                    b.Property<int?>("RolesPermissionsId")
                        .HasColumnType("int");

                    b.Property<string>("Title")
                        .HasColumnType("nvarchar(450)");

                    b.HasKey("Id");

                    b.HasIndex("AdminsPermissionsId");

                    b.HasIndex("CustomersPermissionsId");

                    b.HasIndex("DeliveryPermissionsId");

                    b.HasIndex("MessagesPermissionsId");

                    b.HasIndex("RolesPermissionsId");

                    b.HasIndex("Title")
                        .IsUnique()
                        .HasFilter("[Title] IS NOT NULL");

                    b.ToTable("Roles");
                });

            modelBuilder.Entity("apiplate.Domain.Models.Activity", b =>
                {
                    b.HasOne("apiplate.Domain.Models.Admin", null)
                        .WithMany("Activities")
                        .HasForeignKey("AdminId");
                });

            modelBuilder.Entity("apiplate.Domain.Models.Admin", b =>
                {
                    b.HasOne("apiplate.Domain.Models.Role", "Role")
                        .WithMany()
                        .HasForeignKey("RoleId");

                    b.Navigation("Role");
                });

            modelBuilder.Entity("apiplate.Domain.Models.Notification", b =>
                {
                    b.HasOne("apiplate.Domain.Models.Admin", null)
                        .WithMany("Notifications")
                        .HasForeignKey("AdminId");

                    b.HasOne("apiplate.Domain.Models.Customer", null)
                        .WithMany("Notifications")
                        .HasForeignKey("CustomerId");

                    b.HasOne("apiplate.Domain.Models.DeliveryDriver", null)
                        .WithMany("Notifications")
                        .HasForeignKey("DeliveryDriverId");
                });

            modelBuilder.Entity("apiplate.Domain.Models.Role", b =>
                {
                    b.HasOne("apiplate.Domain.Models.Permission", "AdminsPermissions")
                        .WithMany()
                        .HasForeignKey("AdminsPermissionsId");

                    b.HasOne("apiplate.Domain.Models.Permission", "CustomersPermissions")
                        .WithMany()
                        .HasForeignKey("CustomersPermissionsId");

                    b.HasOne("apiplate.Domain.Models.Permission", "DeliveryPermissions")
                        .WithMany()
                        .HasForeignKey("DeliveryPermissionsId");

                    b.HasOne("apiplate.Domain.Models.Permission", "MessagesPermissions")
                        .WithMany()
                        .HasForeignKey("MessagesPermissionsId");

                    b.HasOne("apiplate.Domain.Models.Permission", "RolesPermissions")
                        .WithMany()
                        .HasForeignKey("RolesPermissionsId");

                    b.Navigation("AdminsPermissions");

                    b.Navigation("CustomersPermissions");

                    b.Navigation("DeliveryPermissions");

                    b.Navigation("MessagesPermissions");

                    b.Navigation("RolesPermissions");
                });

            modelBuilder.Entity("apiplate.Domain.Models.Admin", b =>
                {
                    b.Navigation("Activities");

                    b.Navigation("Notifications");
                });

            modelBuilder.Entity("apiplate.Domain.Models.Customer", b =>
                {
                    b.Navigation("Notifications");
                });

            modelBuilder.Entity("apiplate.Domain.Models.DeliveryDriver", b =>
                {
                    b.Navigation("Notifications");
                });
#pragma warning restore 612, 618
        }
    }
}
