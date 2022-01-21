using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace apiplate.Migrations
{
    public partial class addProductIdToOrderedProduct : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "ProductId",
                table: "OrderedProducts",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "CreatedAt", "LastUpdate", "PasswordHash", "PasswordSalt" },
                values: new object[] { new DateTime(2022, 1, 20, 19, 17, 3, 409, DateTimeKind.Local).AddTicks(1152), new DateTime(2022, 1, 20, 19, 17, 3, 410, DateTimeKind.Local).AddTicks(4024), new byte[] { 24, 156, 211, 129, 219, 102, 253, 172, 117, 230, 28, 23, 210, 116, 234, 60, 192, 19, 82, 109, 94, 32, 196, 162, 67, 208, 88, 99, 148, 221, 116, 213, 12, 170, 163, 57, 133, 146, 254, 103, 156, 245, 160, 228, 205, 221, 101, 138, 57, 31, 94, 86, 82, 68, 6, 102, 80, 113, 104, 5, 210, 42, 150, 5 }, new byte[] { 96, 1, 89, 50, 121, 145, 33, 178, 245, 18, 212, 26, 102, 60, 132, 40, 23, 17, 202, 181, 90, 210, 235, 247, 179, 220, 177, 43, 102, 14, 27, 220, 77, 134, 188, 186, 16, 88, 99, 62, 75, 220, 114, 190, 63, 118, 150, 75, 81, 116, 190, 92, 220, 101, 215, 46, 13, 117, 42, 153, 10, 9, 48, 49, 132, 203, 5, 194, 104, 210, 228, 41, 65, 200, 127, 86, 8, 187, 187, 93, 143, 0, 237, 149, 69, 113, 110, 9, 89, 250, 104, 133, 8, 32, 94, 126, 157, 52, 169, 255, 35, 183, 70, 31, 237, 145, 135, 62, 153, 90, 151, 28, 124, 118, 165, 32, 152, 136, 154, 119, 35, 209, 130, 143, 213, 145, 37, 151 } });

            migrationBuilder.CreateIndex(
                name: "IX_OrderedProducts_ProductId",
                table: "OrderedProducts",
                column: "ProductId");

            migrationBuilder.AddForeignKey(
                name: "FK_OrderedProducts_Products_ProductId",
                table: "OrderedProducts",
                column: "ProductId",
                principalTable: "Products",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_OrderedProducts_Products_ProductId",
                table: "OrderedProducts");

            migrationBuilder.DropIndex(
                name: "IX_OrderedProducts_ProductId",
                table: "OrderedProducts");

            migrationBuilder.DropColumn(
                name: "ProductId",
                table: "OrderedProducts");

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "CreatedAt", "LastUpdate", "PasswordHash", "PasswordSalt" },
                values: new object[] { new DateTime(2022, 1, 20, 12, 50, 37, 973, DateTimeKind.Local).AddTicks(3484), new DateTime(2022, 1, 20, 12, 50, 37, 974, DateTimeKind.Local).AddTicks(4723), new byte[] { 166, 71, 142, 176, 124, 250, 108, 84, 50, 240, 252, 31, 254, 157, 178, 129, 79, 2, 12, 180, 94, 51, 201, 213, 104, 201, 127, 102, 202, 152, 123, 128, 163, 212, 220, 159, 251, 107, 189, 183, 163, 198, 205, 255, 180, 176, 141, 68, 99, 217, 91, 118, 209, 168, 184, 240, 176, 152, 111, 217, 242, 191, 107, 230 }, new byte[] { 92, 141, 251, 162, 99, 150, 253, 225, 187, 53, 65, 24, 212, 242, 242, 184, 216, 78, 240, 99, 36, 127, 132, 153, 174, 238, 230, 153, 249, 49, 202, 210, 41, 68, 211, 226, 134, 83, 106, 0, 45, 104, 26, 208, 151, 139, 95, 85, 122, 196, 88, 190, 173, 236, 143, 230, 167, 255, 92, 92, 137, 50, 102, 41, 67, 64, 16, 113, 21, 57, 229, 151, 143, 175, 153, 118, 73, 15, 118, 77, 58, 196, 15, 20, 45, 49, 211, 101, 106, 226, 10, 51, 212, 203, 225, 103, 61, 71, 200, 139, 56, 45, 25, 254, 240, 114, 95, 231, 120, 184, 130, 19, 228, 225, 254, 242, 215, 243, 177, 242, 44, 230, 1, 234, 97, 243, 189, 92 } });
        }
    }
}
