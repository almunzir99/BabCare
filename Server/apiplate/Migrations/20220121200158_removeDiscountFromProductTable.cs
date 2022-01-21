using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace apiplate.Migrations
{
    public partial class removeDiscountFromProductTable : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Discount",
                table: "Products");

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "CreatedAt", "LastUpdate", "PasswordHash", "PasswordSalt" },
                values: new object[] { new DateTime(2022, 1, 21, 22, 1, 57, 493, DateTimeKind.Local).AddTicks(3128), new DateTime(2022, 1, 21, 22, 1, 57, 494, DateTimeKind.Local).AddTicks(5067), new byte[] { 247, 245, 26, 188, 46, 126, 4, 239, 228, 177, 245, 137, 27, 186, 107, 252, 70, 102, 254, 121, 205, 144, 127, 174, 197, 153, 77, 12, 77, 230, 189, 82, 131, 26, 242, 193, 196, 126, 99, 188, 32, 66, 34, 45, 113, 127, 74, 244, 130, 163, 115, 189, 95, 52, 139, 197, 187, 18, 70, 214, 112, 20, 134, 65 }, new byte[] { 42, 248, 189, 22, 190, 38, 66, 102, 114, 32, 180, 62, 197, 166, 185, 97, 16, 149, 113, 51, 253, 164, 221, 16, 102, 146, 120, 151, 170, 160, 175, 187, 69, 15, 110, 91, 62, 81, 215, 146, 102, 14, 202, 36, 136, 138, 184, 152, 12, 101, 209, 122, 246, 59, 240, 41, 103, 78, 121, 165, 146, 23, 194, 151, 34, 92, 144, 139, 58, 147, 12, 99, 71, 168, 13, 55, 85, 222, 163, 102, 240, 77, 160, 200, 57, 156, 15, 52, 106, 214, 130, 43, 51, 200, 205, 65, 116, 111, 179, 89, 203, 232, 130, 193, 114, 197, 209, 44, 68, 249, 121, 43, 180, 219, 7, 105, 122, 46, 94, 216, 160, 96, 102, 42, 33, 138, 86, 232 } });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "Discount",
                table: "Products",
                type: "int",
                nullable: true);

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "CreatedAt", "LastUpdate", "PasswordHash", "PasswordSalt" },
                values: new object[] { new DateTime(2022, 1, 21, 22, 0, 6, 809, DateTimeKind.Local).AddTicks(8400), new DateTime(2022, 1, 21, 22, 0, 6, 810, DateTimeKind.Local).AddTicks(9278), new byte[] { 108, 86, 132, 194, 169, 181, 149, 182, 248, 131, 8, 161, 86, 56, 210, 214, 187, 53, 165, 43, 50, 28, 102, 56, 242, 238, 242, 95, 120, 104, 146, 56, 139, 105, 200, 249, 207, 0, 229, 187, 192, 68, 117, 104, 3, 97, 142, 153, 172, 26, 207, 136, 173, 47, 188, 149, 98, 145, 25, 154, 152, 188, 214, 84 }, new byte[] { 185, 213, 198, 162, 230, 35, 65, 182, 121, 192, 1, 97, 144, 51, 252, 153, 49, 223, 160, 125, 85, 209, 96, 159, 13, 130, 235, 233, 86, 37, 186, 178, 68, 105, 120, 185, 151, 83, 215, 213, 29, 70, 235, 125, 109, 172, 171, 157, 65, 65, 228, 110, 28, 9, 161, 152, 135, 243, 248, 146, 27, 41, 97, 151, 203, 76, 125, 32, 162, 218, 89, 192, 158, 123, 135, 8, 27, 246, 168, 0, 156, 113, 164, 0, 203, 231, 188, 125, 118, 229, 21, 215, 91, 63, 232, 233, 179, 101, 243, 110, 224, 253, 87, 142, 119, 187, 24, 121, 53, 212, 221, 35, 240, 166, 250, 205, 64, 4, 165, 48, 151, 188, 255, 87, 233, 226, 102, 9 } });
        }
    }
}
