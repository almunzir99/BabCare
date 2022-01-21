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

            modelBuilder.Entity("apiplate.Domain.Models.AddOn", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<int?>("CreatedBy")
                        .HasColumnType("int");

                    b.Property<DateTime>("LastUpdate")
                        .HasColumnType("datetime2");

                    b.Property<double>("Price")
                        .HasColumnType("float");

                    b.Property<int?>("ProductId")
                        .HasColumnType("int");

                    b.Property<string>("Title")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.HasIndex("ProductId");

                    b.ToTable("Addons");
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
                            CreatedAt = new DateTime(2022, 1, 20, 19, 17, 3, 409, DateTimeKind.Local).AddTicks(1152),
                            Email = "almunzir99@gmail.com",
                            IsManager = true,
                            LastUpdate = new DateTime(2022, 1, 20, 19, 17, 3, 410, DateTimeKind.Local).AddTicks(4024),
                            PasswordHash = new byte[] { 24, 156, 211, 129, 219, 102, 253, 172, 117, 230, 28, 23, 210, 116, 234, 60, 192, 19, 82, 109, 94, 32, 196, 162, 67, 208, 88, 99, 148, 221, 116, 213, 12, 170, 163, 57, 133, 146, 254, 103, 156, 245, 160, 228, 205, 221, 101, 138, 57, 31, 94, 86, 82, 68, 6, 102, 80, 113, 104, 5, 210, 42, 150, 5 },
                            PasswordSalt = new byte[] { 96, 1, 89, 50, 121, 145, 33, 178, 245, 18, 212, 26, 102, 60, 132, 40, 23, 17, 202, 181, 90, 210, 235, 247, 179, 220, 177, 43, 102, 14, 27, 220, 77, 134, 188, 186, 16, 88, 99, 62, 75, 220, 114, 190, 63, 118, 150, 75, 81, 116, 190, 92, 220, 101, 215, 46, 13, 117, 42, 153, 10, 9, 48, 49, 132, 203, 5, 194, 104, 210, 228, 41, 65, 200, 127, 86, 8, 187, 187, 93, 143, 0, 237, 149, 69, 113, 110, 9, 89, 250, 104, 133, 8, 32, 94, 126, 157, 52, 169, 255, 35, 183, 70, 31, 237, 145, 135, 62, 153, 90, 151, 28, 124, 118, 165, 32, 152, 136, 154, 119, 35, 209, 130, 143, 213, 145, 37, 151 },
                            Phone = "249128647019",
                            Username = "almunzir99"
                        });
                });

            modelBuilder.Entity("apiplate.Domain.Models.Branch", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<int?>("CreatedBy")
                        .HasColumnType("int");

                    b.Property<DateTime>("LastUpdate")
                        .HasColumnType("datetime2");

                    b.Property<double>("Lat")
                        .HasColumnType("float");

                    b.Property<string>("Location")
                        .HasColumnType("nvarchar(max)");

                    b.Property<double>("Long")
                        .HasColumnType("float");

                    b.Property<string>("Title")
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.ToTable("Branches");
                });

            modelBuilder.Entity("apiplate.Domain.Models.Category", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<int?>("CreatedBy")
                        .HasColumnType("int");

                    b.Property<int?>("ImageId")
                        .HasColumnType("int");

                    b.Property<DateTime>("LastUpdate")
                        .HasColumnType("datetime2");

                    b.Property<string>("Title")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.HasIndex("ImageId");

                    b.ToTable("Categories");
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

            modelBuilder.Entity("apiplate.Domain.Models.Image", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<int?>("CreatedBy")
                        .HasColumnType("int");

                    b.Property<DateTime>("LastUpdate")
                        .HasColumnType("datetime2");

                    b.Property<string>("Path")
                        .HasColumnType("nvarchar(max)");

                    b.Property<int?>("ProductId")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.HasIndex("ProductId");

                    b.ToTable("Image");
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

            modelBuilder.Entity("apiplate.Domain.Models.Option", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<int?>("CreatedBy")
                        .HasColumnType("int");

                    b.Property<DateTime>("LastUpdate")
                        .HasColumnType("datetime2");

                    b.Property<int?>("ProductId")
                        .HasColumnType("int");

                    b.Property<string>("Title")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.HasIndex("ProductId");

                    b.ToTable("Options");
                });

            modelBuilder.Entity("apiplate.Domain.Models.OptionValue", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<int?>("CreatedBy")
                        .HasColumnType("int");

                    b.Property<DateTime>("LastUpdate")
                        .HasColumnType("datetime2");

                    b.Property<int?>("OptionId")
                        .HasColumnType("int");

                    b.Property<string>("Title")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<int>("Value")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.HasIndex("OptionId");

                    b.ToTable("OptionValues");
                });

            modelBuilder.Entity("apiplate.Domain.Models.Order", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<int>("BranchId")
                        .HasColumnType("int");

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<int?>("CreatedBy")
                        .HasColumnType("int");

                    b.Property<int>("CustomerId")
                        .HasColumnType("int");

                    b.Property<double>("DeliveryAmount")
                        .HasColumnType("float");

                    b.Property<int?>("DeliveryId")
                        .HasColumnType("int");

                    b.Property<bool>("IsPaid")
                        .HasColumnType("bit");

                    b.Property<DateTime>("LastUpdate")
                        .HasColumnType("datetime2");

                    b.Property<double>("Lat")
                        .HasColumnType("float");

                    b.Property<string>("Location")
                        .HasColumnType("nvarchar(max)");

                    b.Property<double>("Long")
                        .HasColumnType("float");

                    b.Property<string>("OrderFeedback")
                        .HasColumnType("nvarchar(max)");

                    b.Property<int>("PaymentType")
                        .HasColumnType("int");

                    b.Property<int>("Status")
                        .HasColumnType("int");

                    b.Property<double>("Total")
                        .HasColumnType("float");

                    b.HasKey("Id");

                    b.HasIndex("BranchId");

                    b.HasIndex("CustomerId");

                    b.HasIndex("DeliveryId");

                    b.ToTable("Orders");
                });

            modelBuilder.Entity("apiplate.Domain.Models.OrderedAddon", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<int>("AddonIndex")
                        .HasColumnType("int");

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<int?>("CreatedBy")
                        .HasColumnType("int");

                    b.Property<DateTime>("LastUpdate")
                        .HasColumnType("datetime2");

                    b.Property<int?>("OrderedProductId")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.HasIndex("OrderedProductId");

                    b.ToTable("OrderedAddons");
                });

            modelBuilder.Entity("apiplate.Domain.Models.OrderedOption", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<int?>("CreatedBy")
                        .HasColumnType("int");

                    b.Property<DateTime>("LastUpdate")
                        .HasColumnType("datetime2");

                    b.Property<int>("OptionIndex")
                        .HasColumnType("int");

                    b.Property<int>("OptionValueIndex")
                        .HasColumnType("int");

                    b.Property<int?>("OrderedProductId")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.HasIndex("OrderedProductId");

                    b.ToTable("OrderedOptions");
                });

            modelBuilder.Entity("apiplate.Domain.Models.OrderedProduct", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<int?>("CreatedBy")
                        .HasColumnType("int");

                    b.Property<DateTime>("LastUpdate")
                        .HasColumnType("datetime2");

                    b.Property<int?>("OrderId")
                        .HasColumnType("int");

                    b.Property<int>("ProductId")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.HasIndex("OrderId");

                    b.HasIndex("ProductId");

                    b.ToTable("OrderedProducts");
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

            modelBuilder.Entity("apiplate.Domain.Models.Product", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<int>("CategoryId")
                        .HasColumnType("int");

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<int?>("CreatedBy")
                        .HasColumnType("int");

                    b.Property<string>("Description")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<int?>("Discount")
                        .HasColumnType("int");

                    b.Property<DateTime>("LastUpdate")
                        .HasColumnType("datetime2");

                    b.Property<double>("Price")
                        .HasColumnType("float");

                    b.Property<string>("Title")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.HasIndex("CategoryId");

                    b.ToTable("Products");
                });

            modelBuilder.Entity("apiplate.Domain.Models.Role", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<int?>("AdminsPermissionsId")
                        .HasColumnType("int");

                    b.Property<int?>("BranchesPermissonId")
                        .HasColumnType("int");

                    b.Property<int?>("CategoriesPermissonId")
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

                    b.Property<int?>("ProductsPermissonId")
                        .HasColumnType("int");

                    b.Property<int?>("RolesPermissionsId")
                        .HasColumnType("int");

                    b.Property<string>("Title")
                        .HasColumnType("nvarchar(450)");

                    b.HasKey("Id");

                    b.HasIndex("AdminsPermissionsId");

                    b.HasIndex("BranchesPermissonId");

                    b.HasIndex("CategoriesPermissonId");

                    b.HasIndex("CustomersPermissionsId");

                    b.HasIndex("DeliveryPermissionsId");

                    b.HasIndex("MessagesPermissionsId");

                    b.HasIndex("ProductsPermissonId");

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

            modelBuilder.Entity("apiplate.Domain.Models.AddOn", b =>
                {
                    b.HasOne("apiplate.Domain.Models.Product", null)
                        .WithMany("AddOns")
                        .HasForeignKey("ProductId");
                });

            modelBuilder.Entity("apiplate.Domain.Models.Admin", b =>
                {
                    b.HasOne("apiplate.Domain.Models.Role", "Role")
                        .WithMany()
                        .HasForeignKey("RoleId");

                    b.Navigation("Role");
                });

            modelBuilder.Entity("apiplate.Domain.Models.Category", b =>
                {
                    b.HasOne("apiplate.Domain.Models.Image", "Image")
                        .WithMany()
                        .HasForeignKey("ImageId");

                    b.Navigation("Image");
                });

            modelBuilder.Entity("apiplate.Domain.Models.Image", b =>
                {
                    b.HasOne("apiplate.Domain.Models.Product", null)
                        .WithMany("Images")
                        .HasForeignKey("ProductId");
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

            modelBuilder.Entity("apiplate.Domain.Models.Option", b =>
                {
                    b.HasOne("apiplate.Domain.Models.Product", null)
                        .WithMany("Options")
                        .HasForeignKey("ProductId");
                });

            modelBuilder.Entity("apiplate.Domain.Models.OptionValue", b =>
                {
                    b.HasOne("apiplate.Domain.Models.Option", null)
                        .WithMany("Values")
                        .HasForeignKey("OptionId");
                });

            modelBuilder.Entity("apiplate.Domain.Models.Order", b =>
                {
                    b.HasOne("apiplate.Domain.Models.Branch", "Branch")
                        .WithMany()
                        .HasForeignKey("BranchId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("apiplate.Domain.Models.Customer", "Customer")
                        .WithMany()
                        .HasForeignKey("CustomerId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("apiplate.Domain.Models.DeliveryDriver", "Delivery")
                        .WithMany()
                        .HasForeignKey("DeliveryId");

                    b.Navigation("Branch");

                    b.Navigation("Customer");

                    b.Navigation("Delivery");
                });

            modelBuilder.Entity("apiplate.Domain.Models.OrderedAddon", b =>
                {
                    b.HasOne("apiplate.Domain.Models.OrderedProduct", null)
                        .WithMany("OrderedAddons")
                        .HasForeignKey("OrderedProductId");
                });

            modelBuilder.Entity("apiplate.Domain.Models.OrderedOption", b =>
                {
                    b.HasOne("apiplate.Domain.Models.OrderedProduct", null)
                        .WithMany("OrderedOptions")
                        .HasForeignKey("OrderedProductId");
                });

            modelBuilder.Entity("apiplate.Domain.Models.OrderedProduct", b =>
                {
                    b.HasOne("apiplate.Domain.Models.Order", null)
                        .WithMany("Products")
                        .HasForeignKey("OrderId");

                    b.HasOne("apiplate.Domain.Models.Product", "Product")
                        .WithMany()
                        .HasForeignKey("ProductId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Product");
                });

            modelBuilder.Entity("apiplate.Domain.Models.Product", b =>
                {
                    b.HasOne("apiplate.Domain.Models.Category", "Category")
                        .WithMany("Products")
                        .HasForeignKey("CategoryId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Category");
                });

            modelBuilder.Entity("apiplate.Domain.Models.Role", b =>
                {
                    b.HasOne("apiplate.Domain.Models.Permission", "AdminsPermissions")
                        .WithMany()
                        .HasForeignKey("AdminsPermissionsId");

                    b.HasOne("apiplate.Domain.Models.Permission", "BranchesPermisson")
                        .WithMany()
                        .HasForeignKey("BranchesPermissonId");

                    b.HasOne("apiplate.Domain.Models.Permission", "CategoriesPermisson")
                        .WithMany()
                        .HasForeignKey("CategoriesPermissonId");

                    b.HasOne("apiplate.Domain.Models.Permission", "CustomersPermissions")
                        .WithMany()
                        .HasForeignKey("CustomersPermissionsId");

                    b.HasOne("apiplate.Domain.Models.Permission", "DeliveryPermissions")
                        .WithMany()
                        .HasForeignKey("DeliveryPermissionsId");

                    b.HasOne("apiplate.Domain.Models.Permission", "MessagesPermissions")
                        .WithMany()
                        .HasForeignKey("MessagesPermissionsId");

                    b.HasOne("apiplate.Domain.Models.Permission", "ProductsPermisson")
                        .WithMany()
                        .HasForeignKey("ProductsPermissonId");

                    b.HasOne("apiplate.Domain.Models.Permission", "RolesPermissions")
                        .WithMany()
                        .HasForeignKey("RolesPermissionsId");

                    b.Navigation("AdminsPermissions");

                    b.Navigation("BranchesPermisson");

                    b.Navigation("CategoriesPermisson");

                    b.Navigation("CustomersPermissions");

                    b.Navigation("DeliveryPermissions");

                    b.Navigation("MessagesPermissions");

                    b.Navigation("ProductsPermisson");

                    b.Navigation("RolesPermissions");
                });

            modelBuilder.Entity("apiplate.Domain.Models.Admin", b =>
                {
                    b.Navigation("Activities");

                    b.Navigation("Notifications");
                });

            modelBuilder.Entity("apiplate.Domain.Models.Category", b =>
                {
                    b.Navigation("Products");
                });

            modelBuilder.Entity("apiplate.Domain.Models.Customer", b =>
                {
                    b.Navigation("Notifications");
                });

            modelBuilder.Entity("apiplate.Domain.Models.DeliveryDriver", b =>
                {
                    b.Navigation("Notifications");
                });

            modelBuilder.Entity("apiplate.Domain.Models.Option", b =>
                {
                    b.Navigation("Values");
                });

            modelBuilder.Entity("apiplate.Domain.Models.Order", b =>
                {
                    b.Navigation("Products");
                });

            modelBuilder.Entity("apiplate.Domain.Models.OrderedProduct", b =>
                {
                    b.Navigation("OrderedAddons");

                    b.Navigation("OrderedOptions");
                });

            modelBuilder.Entity("apiplate.Domain.Models.Product", b =>
                {
                    b.Navigation("AddOns");

                    b.Navigation("Images");

                    b.Navigation("Options");
                });
#pragma warning restore 612, 618
        }
    }
}
