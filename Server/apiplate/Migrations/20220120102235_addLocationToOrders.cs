using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace apiplate.Migrations
{
    public partial class addLocationToOrders : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "Location",
                table: "Orders",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "CreatedAt", "LastUpdate", "PasswordHash", "PasswordSalt" },
                values: new object[] { new DateTime(2022, 1, 20, 12, 22, 34, 518, DateTimeKind.Local).AddTicks(5189), new DateTime(2022, 1, 20, 12, 22, 34, 519, DateTimeKind.Local).AddTicks(6196), new byte[] { 78, 171, 206, 144, 248, 23, 126, 250, 91, 108, 33, 80, 79, 134, 6, 74, 10, 178, 218, 169, 25, 97, 37, 219, 228, 86, 113, 22, 56, 148, 35, 43, 29, 23, 247, 192, 185, 21, 139, 13, 200, 60, 5, 28, 248, 112, 105, 13, 129, 235, 248, 67, 49, 132, 67, 246, 175, 244, 191, 227, 232, 244, 107, 124 }, new byte[] { 171, 242, 252, 91, 198, 220, 118, 170, 41, 208, 25, 138, 127, 204, 151, 61, 166, 118, 212, 101, 150, 115, 60, 151, 83, 35, 229, 45, 90, 242, 13, 65, 212, 161, 91, 157, 221, 38, 80, 81, 30, 251, 82, 253, 122, 183, 53, 56, 22, 41, 199, 143, 14, 219, 117, 114, 128, 107, 57, 54, 191, 141, 208, 110, 240, 187, 77, 155, 249, 46, 111, 135, 6, 230, 191, 172, 153, 56, 108, 9, 86, 34, 144, 230, 93, 62, 190, 52, 104, 223, 21, 177, 49, 172, 179, 59, 102, 50, 145, 241, 71, 139, 145, 35, 140, 90, 93, 249, 250, 26, 92, 188, 244, 104, 32, 192, 49, 43, 120, 232, 140, 135, 186, 34, 63, 184, 76, 8 } });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Location",
                table: "Orders");

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "CreatedAt", "LastUpdate", "PasswordHash", "PasswordSalt" },
                values: new object[] { new DateTime(2022, 1, 20, 12, 4, 8, 958, DateTimeKind.Local).AddTicks(2976), new DateTime(2022, 1, 20, 12, 4, 8, 959, DateTimeKind.Local).AddTicks(4005), new byte[] { 65, 101, 161, 240, 170, 91, 192, 203, 192, 161, 184, 173, 89, 148, 163, 196, 176, 187, 202, 198, 129, 181, 98, 171, 2, 36, 185, 100, 110, 75, 1, 205, 244, 110, 182, 51, 96, 141, 6, 183, 114, 86, 163, 160, 186, 226, 90, 112, 99, 99, 239, 162, 187, 238, 24, 40, 103, 2, 224, 192, 199, 243, 244, 179 }, new byte[] { 57, 141, 182, 199, 9, 221, 58, 68, 204, 177, 168, 121, 16, 189, 130, 240, 242, 121, 5, 88, 139, 74, 161, 162, 15, 110, 73, 248, 139, 5, 174, 65, 247, 163, 192, 48, 50, 25, 88, 188, 126, 215, 231, 203, 50, 214, 108, 144, 153, 158, 41, 8, 42, 5, 32, 249, 67, 210, 158, 38, 163, 166, 21, 25, 126, 91, 41, 196, 102, 74, 85, 88, 54, 102, 156, 136, 22, 194, 133, 46, 157, 212, 19, 206, 178, 5, 116, 214, 80, 35, 241, 136, 80, 207, 9, 152, 46, 90, 55, 31, 111, 157, 228, 83, 205, 238, 56, 190, 159, 43, 164, 140, 183, 33, 207, 91, 129, 14, 139, 237, 2, 159, 238, 143, 39, 3, 5, 181 } });
        }
    }
}
