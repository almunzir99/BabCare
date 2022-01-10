using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace apiplate.Migrations
{
    public partial class changeIndexToEmailAndChangeEmail : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_Users_Username",
                table: "Users");

            migrationBuilder.AlterColumn<string>(
                name: "Email",
                table: "Users",
                type: "nvarchar(450)",
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)");

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "CreatedAt", "Email", "LastUpdate", "PasswordHash", "PasswordSalt" },
                values: new object[] { new DateTime(2022, 1, 6, 19, 15, 31, 405, DateTimeKind.Local).AddTicks(1782), "almunzir99@gmail.com", new DateTime(2022, 1, 6, 19, 15, 31, 406, DateTimeKind.Local).AddTicks(2605), new byte[] { 73, 218, 218, 62, 7, 45, 61, 253, 255, 224, 21, 6, 232, 76, 64, 68, 4, 70, 252, 240, 190, 73, 17, 228, 212, 29, 195, 142, 57, 218, 190, 94, 141, 137, 27, 97, 177, 224, 183, 127, 254, 75, 73, 4, 6, 195, 132, 87, 99, 29, 72, 30, 160, 213, 254, 205, 105, 69, 104, 177, 121, 79, 156, 251 }, new byte[] { 175, 160, 68, 94, 79, 216, 65, 90, 84, 32, 200, 82, 48, 188, 189, 76, 247, 159, 152, 16, 113, 132, 2, 101, 69, 231, 102, 15, 28, 182, 46, 72, 51, 199, 196, 18, 211, 54, 57, 115, 67, 29, 144, 33, 187, 162, 109, 65, 55, 71, 206, 129, 142, 188, 45, 99, 172, 169, 113, 96, 50, 0, 64, 203, 107, 38, 33, 252, 244, 64, 237, 173, 146, 242, 87, 101, 163, 238, 39, 166, 34, 95, 56, 229, 214, 95, 43, 233, 198, 47, 78, 134, 242, 4, 172, 129, 40, 123, 132, 77, 237, 137, 243, 174, 114, 77, 162, 168, 149, 115, 26, 3, 149, 11, 79, 130, 174, 75, 144, 229, 2, 140, 105, 6, 163, 254, 237, 109 } });

            migrationBuilder.CreateIndex(
                name: "IX_Users_Email",
                table: "Users",
                column: "Email",
                unique: true);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_Users_Email",
                table: "Users");

            migrationBuilder.AlterColumn<string>(
                name: "Email",
                table: "Users",
                type: "nvarchar(max)",
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(450)");

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "CreatedAt", "Email", "LastUpdate", "PasswordHash", "PasswordSalt" },
                values: new object[] { new DateTime(2022, 1, 6, 18, 33, 8, 567, DateTimeKind.Local).AddTicks(3500), "almunzir99", new DateTime(2022, 1, 6, 18, 33, 8, 568, DateTimeKind.Local).AddTicks(4075), new byte[] { 65, 198, 130, 34, 178, 7, 202, 175, 141, 161, 158, 192, 93, 209, 225, 11, 209, 142, 164, 62, 162, 104, 7, 97, 169, 99, 117, 190, 220, 107, 34, 130, 153, 70, 121, 248, 131, 28, 237, 52, 155, 4, 100, 141, 112, 254, 254, 233, 175, 183, 184, 150, 4, 111, 208, 235, 67, 23, 171, 195, 115, 237, 3, 160 }, new byte[] { 25, 76, 222, 21, 73, 245, 201, 36, 78, 153, 159, 213, 88, 183, 2, 174, 114, 76, 159, 41, 173, 138, 167, 17, 113, 6, 112, 223, 168, 115, 119, 183, 171, 251, 135, 232, 51, 188, 150, 201, 44, 129, 107, 117, 4, 27, 22, 53, 229, 8, 98, 89, 187, 96, 156, 149, 55, 123, 159, 65, 159, 70, 184, 230, 44, 121, 20, 122, 46, 205, 247, 228, 209, 38, 179, 222, 105, 0, 1, 97, 67, 47, 125, 252, 100, 162, 213, 53, 103, 79, 172, 253, 55, 3, 10, 207, 146, 251, 101, 53, 16, 27, 122, 251, 78, 30, 88, 43, 15, 82, 93, 101, 25, 20, 118, 98, 245, 138, 212, 71, 170, 71, 171, 211, 170, 43, 97, 34 } });

            migrationBuilder.CreateIndex(
                name: "IX_Users_Username",
                table: "Users",
                column: "Username",
                unique: true);
        }
    }
}
