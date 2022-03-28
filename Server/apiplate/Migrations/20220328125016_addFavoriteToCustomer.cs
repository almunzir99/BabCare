using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace apiplate.Migrations
{
    public partial class addFavoriteToCustomer : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Favorites",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    ProductId = table.Column<int>(type: "int", nullable: false),
                    CustomerId = table.Column<int>(type: "int", nullable: true),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    LastUpdate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    CreatedBy = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Favorites", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Favorites_Customers_CustomerId",
                        column: x => x.CustomerId,
                        principalTable: "Customers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_Favorites_Products_ProductId",
                        column: x => x.ProductId,
                        principalTable: "Products",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "CreatedAt", "LastUpdate", "PasswordHash", "PasswordSalt" },
                values: new object[] { new DateTime(2022, 3, 28, 14, 50, 15, 489, DateTimeKind.Local).AddTicks(1107), new DateTime(2022, 3, 28, 14, 50, 15, 495, DateTimeKind.Local).AddTicks(3145), new byte[] { 246, 57, 186, 57, 238, 145, 192, 39, 17, 162, 110, 11, 204, 208, 90, 235, 55, 153, 155, 122, 170, 164, 10, 116, 145, 240, 152, 169, 172, 28, 162, 222, 198, 80, 163, 13, 31, 237, 90, 245, 129, 170, 106, 36, 125, 140, 211, 206, 106, 61, 75, 14, 149, 40, 248, 79, 48, 29, 139, 140, 3, 129, 252, 11 }, new byte[] { 134, 126, 65, 243, 69, 205, 33, 108, 35, 121, 99, 191, 163, 215, 207, 179, 93, 174, 245, 121, 71, 188, 147, 157, 13, 48, 161, 2, 115, 64, 114, 2, 240, 102, 254, 139, 196, 43, 124, 124, 211, 10, 63, 36, 151, 221, 141, 23, 193, 67, 139, 29, 79, 129, 95, 79, 66, 166, 82, 22, 148, 93, 123, 187, 182, 3, 70, 89, 146, 97, 251, 229, 242, 64, 169, 202, 168, 163, 71, 8, 1, 31, 233, 86, 29, 66, 2, 150, 58, 45, 136, 251, 192, 19, 100, 92, 234, 240, 154, 202, 29, 102, 193, 52, 28, 46, 159, 232, 68, 86, 145, 186, 249, 141, 113, 150, 138, 154, 198, 22, 63, 17, 247, 176, 172, 205, 217, 205 } });

            migrationBuilder.CreateIndex(
                name: "IX_Favorites_CustomerId",
                table: "Favorites",
                column: "CustomerId");

            migrationBuilder.CreateIndex(
                name: "IX_Favorites_ProductId",
                table: "Favorites",
                column: "ProductId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Favorites");

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "CreatedAt", "LastUpdate", "PasswordHash", "PasswordSalt" },
                values: new object[] { new DateTime(2022, 3, 21, 18, 40, 6, 246, DateTimeKind.Local).AddTicks(5994), new DateTime(2022, 3, 21, 18, 40, 6, 412, DateTimeKind.Local).AddTicks(2488), new byte[] { 119, 10, 95, 231, 29, 43, 99, 0, 73, 115, 51, 144, 172, 41, 104, 210, 32, 71, 94, 234, 152, 114, 112, 64, 100, 147, 13, 15, 188, 92, 223, 81, 87, 21, 227, 229, 218, 101, 242, 239, 151, 11, 82, 113, 253, 229, 204, 31, 250, 126, 246, 232, 60, 125, 218, 183, 214, 97, 72, 4, 131, 107, 206, 239 }, new byte[] { 70, 106, 17, 132, 11, 98, 116, 125, 7, 7, 183, 102, 172, 195, 142, 97, 18, 93, 128, 123, 225, 239, 76, 124, 55, 90, 189, 23, 66, 249, 91, 170, 160, 184, 19, 57, 189, 140, 132, 110, 146, 67, 247, 43, 139, 56, 57, 138, 99, 129, 229, 69, 46, 204, 112, 250, 53, 144, 86, 51, 92, 137, 5, 52, 203, 170, 38, 146, 147, 117, 172, 105, 221, 85, 3, 65, 255, 154, 63, 4, 88, 238, 109, 130, 65, 127, 33, 190, 134, 241, 165, 185, 245, 107, 177, 35, 21, 35, 25, 203, 116, 163, 208, 92, 9, 96, 35, 103, 210, 184, 19, 186, 28, 43, 244, 47, 41, 84, 186, 104, 185, 114, 36, 122, 67, 241, 158, 230 } });
        }
    }
}
