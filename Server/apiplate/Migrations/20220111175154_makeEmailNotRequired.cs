using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace apiplate.Migrations
{
    public partial class makeEmailNotRequired : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_Users_Email",
                table: "Users");

            migrationBuilder.AlterColumn<string>(
                name: "Email",
                table: "Users",
                type: "nvarchar(450)",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(450)");

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "CreatedAt", "LastUpdate", "PasswordHash", "PasswordSalt" },
                values: new object[] { new DateTime(2022, 1, 11, 19, 51, 54, 190, DateTimeKind.Local).AddTicks(8576), new DateTime(2022, 1, 11, 19, 51, 54, 192, DateTimeKind.Local).AddTicks(2208), new byte[] { 155, 209, 165, 192, 126, 124, 146, 64, 150, 227, 174, 93, 32, 207, 204, 145, 82, 131, 131, 189, 1, 240, 230, 176, 92, 184, 233, 226, 24, 24, 62, 128, 82, 84, 45, 202, 161, 170, 254, 75, 229, 226, 74, 225, 184, 130, 24, 204, 138, 220, 171, 234, 110, 76, 68, 77, 145, 53, 39, 112, 185, 37, 39, 183 }, new byte[] { 100, 10, 135, 187, 172, 40, 133, 55, 77, 141, 77, 104, 137, 92, 184, 217, 11, 55, 74, 169, 53, 172, 147, 244, 110, 204, 212, 153, 217, 205, 148, 251, 123, 215, 13, 213, 182, 23, 13, 197, 187, 91, 22, 93, 122, 64, 255, 74, 188, 73, 105, 122, 35, 175, 8, 16, 157, 237, 140, 255, 60, 153, 121, 86, 125, 52, 220, 49, 126, 39, 131, 226, 114, 86, 44, 42, 222, 136, 79, 21, 195, 117, 36, 63, 34, 247, 35, 148, 10, 43, 190, 67, 145, 91, 64, 72, 150, 196, 98, 65, 220, 174, 47, 35, 214, 150, 97, 154, 28, 233, 135, 66, 237, 249, 73, 168, 24, 57, 37, 38, 205, 57, 52, 63, 88, 36, 255, 254 } });

            migrationBuilder.CreateIndex(
                name: "IX_Users_Email",
                table: "Users",
                column: "Email",
                unique: true,
                filter: "[Email] IS NOT NULL");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_Users_Email",
                table: "Users");

            migrationBuilder.AlterColumn<string>(
                name: "Email",
                table: "Users",
                type: "nvarchar(450)",
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(string),
                oldType: "nvarchar(450)",
                oldNullable: true);

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "CreatedAt", "LastUpdate", "PasswordHash", "PasswordSalt" },
                values: new object[] { new DateTime(2022, 1, 6, 19, 15, 31, 405, DateTimeKind.Local).AddTicks(1782), new DateTime(2022, 1, 6, 19, 15, 31, 406, DateTimeKind.Local).AddTicks(2605), new byte[] { 73, 218, 218, 62, 7, 45, 61, 253, 255, 224, 21, 6, 232, 76, 64, 68, 4, 70, 252, 240, 190, 73, 17, 228, 212, 29, 195, 142, 57, 218, 190, 94, 141, 137, 27, 97, 177, 224, 183, 127, 254, 75, 73, 4, 6, 195, 132, 87, 99, 29, 72, 30, 160, 213, 254, 205, 105, 69, 104, 177, 121, 79, 156, 251 }, new byte[] { 175, 160, 68, 94, 79, 216, 65, 90, 84, 32, 200, 82, 48, 188, 189, 76, 247, 159, 152, 16, 113, 132, 2, 101, 69, 231, 102, 15, 28, 182, 46, 72, 51, 199, 196, 18, 211, 54, 57, 115, 67, 29, 144, 33, 187, 162, 109, 65, 55, 71, 206, 129, 142, 188, 45, 99, 172, 169, 113, 96, 50, 0, 64, 203, 107, 38, 33, 252, 244, 64, 237, 173, 146, 242, 87, 101, 163, 238, 39, 166, 34, 95, 56, 229, 214, 95, 43, 233, 198, 47, 78, 134, 242, 4, 172, 129, 40, 123, 132, 77, 237, 137, 243, 174, 114, 77, 162, 168, 149, 115, 26, 3, 149, 11, 79, 130, 174, 75, 144, 229, 2, 140, 105, 6, 163, 254, 237, 109 } });

            migrationBuilder.CreateIndex(
                name: "IX_Users_Email",
                table: "Users",
                column: "Email",
                unique: true);
        }
    }
}
