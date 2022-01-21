using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace apiplate.Migrations
{
    public partial class removeCategoryFromOfferTable : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Offers_Categories_CategoryId",
                table: "Offers");

            migrationBuilder.DropIndex(
                name: "IX_Offers_CategoryId",
                table: "Offers");

            migrationBuilder.DropColumn(
                name: "CategoryId",
                table: "Offers");

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "CreatedAt", "LastUpdate", "PasswordHash", "PasswordSalt" },
                values: new object[] { new DateTime(2022, 1, 21, 22, 13, 44, 187, DateTimeKind.Local).AddTicks(720), new DateTime(2022, 1, 21, 22, 13, 44, 188, DateTimeKind.Local).AddTicks(2191), new byte[] { 232, 35, 42, 19, 192, 155, 89, 36, 10, 163, 239, 202, 239, 178, 83, 116, 46, 57, 52, 43, 203, 232, 113, 221, 213, 64, 199, 111, 38, 5, 62, 88, 67, 244, 14, 142, 234, 62, 161, 57, 216, 102, 239, 155, 56, 96, 115, 111, 95, 51, 138, 165, 102, 91, 168, 133, 56, 66, 131, 253, 169, 40, 119, 30 }, new byte[] { 206, 211, 239, 155, 20, 148, 105, 79, 195, 43, 225, 141, 170, 45, 102, 170, 22, 126, 180, 96, 56, 198, 242, 216, 3, 196, 218, 184, 115, 40, 53, 5, 255, 46, 42, 145, 126, 190, 87, 61, 141, 88, 0, 143, 27, 186, 140, 232, 122, 226, 33, 29, 10, 21, 43, 6, 4, 147, 142, 25, 166, 169, 155, 234, 116, 156, 36, 94, 104, 59, 83, 218, 83, 217, 232, 83, 81, 189, 182, 234, 115, 189, 212, 227, 86, 222, 202, 67, 177, 181, 60, 245, 176, 236, 39, 183, 113, 8, 155, 148, 216, 127, 115, 132, 10, 18, 100, 160, 29, 28, 131, 230, 148, 185, 29, 207, 119, 135, 89, 171, 110, 248, 11, 51, 207, 96, 167, 22 } });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "CategoryId",
                table: "Offers",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "CreatedAt", "LastUpdate", "PasswordHash", "PasswordSalt" },
                values: new object[] { new DateTime(2022, 1, 21, 22, 11, 3, 216, DateTimeKind.Local).AddTicks(1581), new DateTime(2022, 1, 21, 22, 11, 3, 218, DateTimeKind.Local).AddTicks(2557), new byte[] { 178, 175, 93, 121, 4, 45, 210, 26, 168, 203, 10, 255, 207, 33, 170, 235, 243, 132, 244, 9, 183, 206, 107, 192, 44, 51, 59, 219, 91, 17, 86, 198, 49, 171, 96, 51, 250, 185, 171, 130, 4, 102, 253, 75, 221, 210, 135, 224, 90, 173, 114, 123, 249, 122, 50, 99, 246, 140, 197, 30, 85, 125, 155, 101 }, new byte[] { 36, 9, 88, 210, 234, 40, 215, 75, 189, 248, 238, 160, 114, 205, 12, 95, 93, 58, 176, 126, 244, 123, 205, 196, 32, 81, 53, 208, 145, 216, 58, 228, 150, 95, 115, 97, 199, 14, 205, 4, 90, 6, 41, 56, 41, 254, 15, 253, 173, 7, 49, 11, 90, 117, 107, 92, 139, 225, 95, 229, 25, 136, 181, 53, 163, 254, 69, 36, 116, 139, 115, 200, 251, 15, 118, 190, 2, 254, 137, 147, 54, 141, 201, 246, 92, 31, 71, 96, 238, 176, 187, 163, 219, 48, 85, 36, 31, 64, 45, 254, 152, 143, 232, 227, 220, 93, 18, 175, 222, 201, 46, 90, 73, 11, 120, 77, 33, 224, 166, 89, 228, 161, 1, 93, 27, 62, 5, 158 } });

            migrationBuilder.CreateIndex(
                name: "IX_Offers_CategoryId",
                table: "Offers",
                column: "CategoryId");

            migrationBuilder.AddForeignKey(
                name: "FK_Offers_Categories_CategoryId",
                table: "Offers",
                column: "CategoryId",
                principalTable: "Categories",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
