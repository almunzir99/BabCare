using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace apiplate.Migrations
{
    public partial class createCategoryAndProductAndRelatedTables : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Products",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Title = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Price = table.Column<double>(type: "float", nullable: false),
                    Discount = table.Column<int>(type: "int", nullable: true),
                    CategoryId = table.Column<int>(type: "int", nullable: false),
                    Description = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    LastUpdate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    CreatedBy = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Products", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Addons",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Title = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Price = table.Column<double>(type: "float", nullable: false),
                    ProductId = table.Column<int>(type: "int", nullable: true),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    LastUpdate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    CreatedBy = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Addons", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Addons_Products_ProductId",
                        column: x => x.ProductId,
                        principalTable: "Products",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "Image",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Path = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    ProductId = table.Column<int>(type: "int", nullable: true),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    LastUpdate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    CreatedBy = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Image", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Image_Products_ProductId",
                        column: x => x.ProductId,
                        principalTable: "Products",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "Options",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Title = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    ProductId = table.Column<int>(type: "int", nullable: true),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    LastUpdate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    CreatedBy = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Options", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Options_Products_ProductId",
                        column: x => x.ProductId,
                        principalTable: "Products",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "Categories",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Title = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    ImageId = table.Column<int>(type: "int", nullable: true),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    LastUpdate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    CreatedBy = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Categories", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Categories_Image_ImageId",
                        column: x => x.ImageId,
                        principalTable: "Image",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "OptionValues",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Title = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Value = table.Column<int>(type: "int", nullable: false),
                    OptionId = table.Column<int>(type: "int", nullable: true),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    LastUpdate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    CreatedBy = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_OptionValues", x => x.Id);
                    table.ForeignKey(
                        name: "FK_OptionValues_Options_OptionId",
                        column: x => x.OptionId,
                        principalTable: "Options",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "CreatedAt", "LastUpdate", "PasswordHash", "PasswordSalt" },
                values: new object[] { new DateTime(2022, 1, 12, 18, 8, 51, 884, DateTimeKind.Local).AddTicks(8642), new DateTime(2022, 1, 12, 18, 8, 51, 886, DateTimeKind.Local).AddTicks(348), new byte[] { 43, 160, 184, 161, 12, 224, 150, 186, 234, 96, 244, 242, 62, 212, 222, 44, 206, 170, 171, 162, 226, 30, 242, 64, 38, 185, 0, 56, 68, 248, 236, 34, 139, 235, 9, 116, 182, 17, 63, 74, 199, 214, 238, 63, 84, 97, 206, 92, 119, 112, 136, 195, 246, 181, 235, 171, 232, 231, 53, 104, 104, 255, 59, 1 }, new byte[] { 15, 158, 82, 123, 127, 171, 36, 16, 120, 150, 190, 0, 151, 165, 228, 127, 20, 43, 89, 89, 54, 151, 226, 6, 227, 100, 249, 163, 141, 189, 233, 0, 202, 32, 30, 65, 200, 249, 88, 149, 202, 238, 89, 141, 219, 221, 195, 146, 164, 104, 185, 237, 27, 4, 61, 3, 87, 116, 116, 13, 37, 115, 103, 195, 63, 197, 51, 20, 226, 30, 99, 242, 218, 158, 84, 208, 228, 8, 99, 249, 158, 104, 109, 54, 129, 249, 39, 118, 214, 124, 79, 79, 241, 202, 83, 127, 171, 134, 35, 140, 32, 96, 202, 11, 151, 180, 13, 37, 162, 227, 88, 221, 94, 101, 27, 18, 210, 255, 79, 171, 114, 111, 170, 34, 10, 158, 169, 220 } });

            migrationBuilder.CreateIndex(
                name: "IX_Addons_ProductId",
                table: "Addons",
                column: "ProductId");

            migrationBuilder.CreateIndex(
                name: "IX_Categories_ImageId",
                table: "Categories",
                column: "ImageId");

            migrationBuilder.CreateIndex(
                name: "IX_Image_ProductId",
                table: "Image",
                column: "ProductId");

            migrationBuilder.CreateIndex(
                name: "IX_Options_ProductId",
                table: "Options",
                column: "ProductId");

            migrationBuilder.CreateIndex(
                name: "IX_OptionValues_OptionId",
                table: "OptionValues",
                column: "OptionId");

            migrationBuilder.CreateIndex(
                name: "IX_Products_CategoryId",
                table: "Products",
                column: "CategoryId");

            migrationBuilder.AddForeignKey(
                name: "FK_Products_Categories_CategoryId",
                table: "Products",
                column: "CategoryId",
                principalTable: "Categories",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Image_Products_ProductId",
                table: "Image");

            migrationBuilder.DropTable(
                name: "Addons");

            migrationBuilder.DropTable(
                name: "OptionValues");

            migrationBuilder.DropTable(
                name: "Options");

            migrationBuilder.DropTable(
                name: "Products");

            migrationBuilder.DropTable(
                name: "Categories");

            migrationBuilder.DropTable(
                name: "Image");

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "CreatedAt", "LastUpdate", "PasswordHash", "PasswordSalt" },
                values: new object[] { new DateTime(2022, 1, 11, 20, 31, 54, 289, DateTimeKind.Local).AddTicks(5), new DateTime(2022, 1, 11, 20, 31, 54, 290, DateTimeKind.Local).AddTicks(1519), new byte[] { 114, 208, 197, 86, 227, 34, 151, 78, 183, 73, 230, 106, 86, 150, 195, 174, 53, 30, 166, 236, 110, 41, 17, 141, 230, 52, 28, 229, 153, 14, 7, 12, 43, 140, 61, 114, 115, 249, 119, 74, 106, 254, 77, 15, 53, 168, 133, 224, 27, 99, 24, 164, 94, 37, 161, 17, 48, 74, 185, 55, 242, 26, 197, 77 }, new byte[] { 0, 160, 94, 6, 75, 119, 195, 42, 67, 196, 169, 139, 42, 68, 35, 24, 75, 131, 10, 228, 118, 169, 15, 194, 196, 234, 184, 174, 138, 38, 147, 151, 165, 217, 249, 116, 25, 25, 0, 73, 230, 108, 49, 249, 5, 214, 18, 27, 122, 71, 240, 232, 220, 143, 163, 57, 78, 240, 204, 235, 163, 103, 81, 191, 2, 244, 248, 169, 116, 220, 174, 109, 176, 143, 237, 50, 7, 113, 56, 20, 220, 88, 128, 12, 69, 50, 240, 60, 99, 191, 27, 105, 181, 12, 180, 2, 176, 64, 26, 188, 104, 204, 84, 176, 5, 40, 68, 28, 206, 223, 109, 155, 213, 41, 24, 246, 206, 199, 207, 33, 6, 243, 84, 79, 67, 5, 95, 181 } });
        }
    }
}
