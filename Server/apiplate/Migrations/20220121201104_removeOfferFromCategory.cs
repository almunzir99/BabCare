using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace apiplate.Migrations
{
    public partial class removeOfferFromCategory : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Categories_Offers_OfferId",
                table: "Categories");

            migrationBuilder.DropIndex(
                name: "IX_Categories_OfferId",
                table: "Categories");

            migrationBuilder.DropColumn(
                name: "OfferId",
                table: "Categories");

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "CreatedAt", "LastUpdate", "PasswordHash", "PasswordSalt" },
                values: new object[] { new DateTime(2022, 1, 21, 22, 11, 3, 216, DateTimeKind.Local).AddTicks(1581), new DateTime(2022, 1, 21, 22, 11, 3, 218, DateTimeKind.Local).AddTicks(2557), new byte[] { 178, 175, 93, 121, 4, 45, 210, 26, 168, 203, 10, 255, 207, 33, 170, 235, 243, 132, 244, 9, 183, 206, 107, 192, 44, 51, 59, 219, 91, 17, 86, 198, 49, 171, 96, 51, 250, 185, 171, 130, 4, 102, 253, 75, 221, 210, 135, 224, 90, 173, 114, 123, 249, 122, 50, 99, 246, 140, 197, 30, 85, 125, 155, 101 }, new byte[] { 36, 9, 88, 210, 234, 40, 215, 75, 189, 248, 238, 160, 114, 205, 12, 95, 93, 58, 176, 126, 244, 123, 205, 196, 32, 81, 53, 208, 145, 216, 58, 228, 150, 95, 115, 97, 199, 14, 205, 4, 90, 6, 41, 56, 41, 254, 15, 253, 173, 7, 49, 11, 90, 117, 107, 92, 139, 225, 95, 229, 25, 136, 181, 53, 163, 254, 69, 36, 116, 139, 115, 200, 251, 15, 118, 190, 2, 254, 137, 147, 54, 141, 201, 246, 92, 31, 71, 96, 238, 176, 187, 163, 219, 48, 85, 36, 31, 64, 45, 254, 152, 143, 232, 227, 220, 93, 18, 175, 222, 201, 46, 90, 73, 11, 120, 77, 33, 224, 166, 89, 228, 161, 1, 93, 27, 62, 5, 158 } });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "OfferId",
                table: "Categories",
                type: "int",
                nullable: true);

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "CreatedAt", "LastUpdate", "PasswordHash", "PasswordSalt" },
                values: new object[] { new DateTime(2022, 1, 21, 22, 1, 57, 493, DateTimeKind.Local).AddTicks(3128), new DateTime(2022, 1, 21, 22, 1, 57, 494, DateTimeKind.Local).AddTicks(5067), new byte[] { 247, 245, 26, 188, 46, 126, 4, 239, 228, 177, 245, 137, 27, 186, 107, 252, 70, 102, 254, 121, 205, 144, 127, 174, 197, 153, 77, 12, 77, 230, 189, 82, 131, 26, 242, 193, 196, 126, 99, 188, 32, 66, 34, 45, 113, 127, 74, 244, 130, 163, 115, 189, 95, 52, 139, 197, 187, 18, 70, 214, 112, 20, 134, 65 }, new byte[] { 42, 248, 189, 22, 190, 38, 66, 102, 114, 32, 180, 62, 197, 166, 185, 97, 16, 149, 113, 51, 253, 164, 221, 16, 102, 146, 120, 151, 170, 160, 175, 187, 69, 15, 110, 91, 62, 81, 215, 146, 102, 14, 202, 36, 136, 138, 184, 152, 12, 101, 209, 122, 246, 59, 240, 41, 103, 78, 121, 165, 146, 23, 194, 151, 34, 92, 144, 139, 58, 147, 12, 99, 71, 168, 13, 55, 85, 222, 163, 102, 240, 77, 160, 200, 57, 156, 15, 52, 106, 214, 130, 43, 51, 200, 205, 65, 116, 111, 179, 89, 203, 232, 130, 193, 114, 197, 209, 44, 68, 249, 121, 43, 180, 219, 7, 105, 122, 46, 94, 216, 160, 96, 102, 42, 33, 138, 86, 232 } });

            migrationBuilder.CreateIndex(
                name: "IX_Categories_OfferId",
                table: "Categories",
                column: "OfferId");

            migrationBuilder.AddForeignKey(
                name: "FK_Categories_Offers_OfferId",
                table: "Categories",
                column: "OfferId",
                principalTable: "Offers",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);
        }
    }
}
