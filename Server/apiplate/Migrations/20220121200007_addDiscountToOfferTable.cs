using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace apiplate.Migrations
{
    public partial class addDiscountToOfferTable : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "Discount",
                table: "Offers",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "CreatedAt", "LastUpdate", "PasswordHash", "PasswordSalt" },
                values: new object[] { new DateTime(2022, 1, 21, 22, 0, 6, 809, DateTimeKind.Local).AddTicks(8400), new DateTime(2022, 1, 21, 22, 0, 6, 810, DateTimeKind.Local).AddTicks(9278), new byte[] { 108, 86, 132, 194, 169, 181, 149, 182, 248, 131, 8, 161, 86, 56, 210, 214, 187, 53, 165, 43, 50, 28, 102, 56, 242, 238, 242, 95, 120, 104, 146, 56, 139, 105, 200, 249, 207, 0, 229, 187, 192, 68, 117, 104, 3, 97, 142, 153, 172, 26, 207, 136, 173, 47, 188, 149, 98, 145, 25, 154, 152, 188, 214, 84 }, new byte[] { 185, 213, 198, 162, 230, 35, 65, 182, 121, 192, 1, 97, 144, 51, 252, 153, 49, 223, 160, 125, 85, 209, 96, 159, 13, 130, 235, 233, 86, 37, 186, 178, 68, 105, 120, 185, 151, 83, 215, 213, 29, 70, 235, 125, 109, 172, 171, 157, 65, 65, 228, 110, 28, 9, 161, 152, 135, 243, 248, 146, 27, 41, 97, 151, 203, 76, 125, 32, 162, 218, 89, 192, 158, 123, 135, 8, 27, 246, 168, 0, 156, 113, 164, 0, 203, 231, 188, 125, 118, 229, 21, 215, 91, 63, 232, 233, 179, 101, 243, 110, 224, 253, 87, 142, 119, 187, 24, 121, 53, 212, 221, 35, 240, 166, 250, 205, 64, 4, 165, 48, 151, 188, 255, 87, 233, 226, 102, 9 } });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Discount",
                table: "Offers");

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "CreatedAt", "LastUpdate", "PasswordHash", "PasswordSalt" },
                values: new object[] { new DateTime(2022, 1, 21, 21, 43, 7, 636, DateTimeKind.Local).AddTicks(1254), new DateTime(2022, 1, 21, 21, 43, 7, 637, DateTimeKind.Local).AddTicks(3275), new byte[] { 153, 116, 144, 151, 244, 6, 18, 75, 214, 51, 150, 5, 27, 197, 186, 15, 204, 58, 39, 104, 185, 204, 63, 185, 220, 162, 33, 81, 232, 59, 44, 7, 115, 217, 89, 7, 155, 74, 36, 169, 235, 225, 121, 218, 163, 45, 45, 189, 113, 119, 149, 144, 239, 208, 107, 85, 104, 58, 84, 250, 205, 180, 83, 88 }, new byte[] { 105, 251, 241, 47, 213, 21, 66, 197, 212, 6, 153, 192, 168, 65, 145, 90, 240, 234, 168, 85, 247, 20, 46, 124, 250, 17, 149, 149, 1, 143, 69, 195, 200, 92, 152, 218, 81, 92, 56, 180, 56, 178, 210, 35, 43, 19, 216, 42, 48, 115, 59, 74, 212, 145, 48, 128, 116, 163, 137, 49, 152, 92, 252, 56, 87, 201, 44, 3, 184, 178, 30, 165, 26, 117, 184, 61, 174, 166, 157, 222, 32, 232, 34, 229, 16, 250, 239, 78, 249, 159, 124, 221, 179, 209, 0, 144, 22, 104, 171, 221, 40, 246, 235, 208, 87, 60, 251, 250, 182, 247, 65, 98, 78, 154, 215, 82, 120, 48, 163, 168, 41, 233, 48, 108, 170, 163, 173, 230 } });
        }
    }
}
