using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace apiplate.Migrations
{
    public partial class makeEmailRequiredForAdmin : Migration
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
                values: new object[] { new DateTime(2022, 1, 11, 20, 9, 28, 294, DateTimeKind.Local).AddTicks(3918), new DateTime(2022, 1, 11, 20, 9, 28, 295, DateTimeKind.Local).AddTicks(8767), new byte[] { 142, 123, 29, 47, 54, 233, 109, 223, 222, 182, 126, 84, 212, 73, 107, 40, 187, 217, 137, 124, 12, 104, 235, 224, 98, 3, 86, 105, 47, 255, 245, 72, 153, 101, 173, 62, 75, 186, 83, 76, 198, 191, 212, 92, 188, 173, 83, 163, 128, 45, 200, 188, 191, 15, 208, 254, 182, 61, 38, 234, 156, 0, 80, 210 }, new byte[] { 206, 73, 253, 89, 239, 176, 224, 221, 237, 182, 137, 5, 97, 67, 28, 155, 103, 66, 237, 183, 91, 234, 172, 131, 116, 159, 125, 168, 148, 20, 105, 11, 196, 64, 254, 62, 111, 195, 59, 119, 94, 119, 191, 8, 194, 66, 27, 218, 213, 60, 101, 182, 30, 166, 223, 108, 59, 136, 61, 109, 26, 130, 3, 145, 37, 183, 15, 72, 234, 113, 235, 228, 203, 16, 181, 59, 12, 220, 158, 7, 53, 104, 220, 138, 41, 73, 240, 50, 36, 27, 224, 139, 217, 232, 157, 130, 208, 208, 112, 120, 37, 136, 123, 100, 184, 4, 104, 252, 139, 5, 166, 39, 31, 81, 228, 111, 14, 140, 80, 37, 166, 201, 176, 223, 178, 241, 71, 170 } });

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
    }
}
