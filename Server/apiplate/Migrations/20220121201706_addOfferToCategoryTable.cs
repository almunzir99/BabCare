using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace apiplate.Migrations
{
    public partial class addOfferToCategoryTable : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
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
                values: new object[] { new DateTime(2022, 1, 21, 22, 17, 5, 334, DateTimeKind.Local).AddTicks(819), new DateTime(2022, 1, 21, 22, 17, 5, 335, DateTimeKind.Local).AddTicks(3847), new byte[] { 125, 184, 134, 107, 254, 203, 210, 61, 134, 243, 92, 212, 168, 11, 19, 78, 19, 32, 88, 45, 215, 141, 125, 229, 127, 59, 199, 145, 209, 82, 101, 148, 169, 51, 231, 111, 217, 255, 236, 197, 200, 205, 199, 40, 211, 42, 177, 64, 195, 5, 23, 86, 224, 181, 14, 176, 151, 167, 186, 170, 184, 20, 150, 137 }, new byte[] { 204, 196, 142, 157, 11, 154, 83, 88, 226, 183, 28, 232, 135, 180, 142, 124, 253, 43, 213, 177, 231, 210, 165, 245, 201, 25, 134, 53, 114, 228, 30, 99, 224, 194, 145, 239, 181, 201, 25, 135, 43, 241, 39, 94, 148, 35, 162, 61, 196, 100, 129, 180, 169, 132, 6, 250, 65, 147, 36, 60, 60, 152, 90, 105, 167, 157, 58, 123, 172, 193, 252, 234, 230, 232, 17, 196, 16, 55, 29, 204, 8, 81, 202, 128, 188, 2, 130, 65, 51, 118, 11, 88, 66, 71, 18, 174, 60, 215, 76, 24, 181, 24, 167, 199, 156, 70, 20, 224, 232, 2, 39, 66, 10, 83, 45, 240, 170, 95, 235, 66, 242, 131, 84, 158, 22, 51, 181, 244 } });

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

        protected override void Down(MigrationBuilder migrationBuilder)
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
                values: new object[] { new DateTime(2022, 1, 21, 22, 13, 44, 187, DateTimeKind.Local).AddTicks(720), new DateTime(2022, 1, 21, 22, 13, 44, 188, DateTimeKind.Local).AddTicks(2191), new byte[] { 232, 35, 42, 19, 192, 155, 89, 36, 10, 163, 239, 202, 239, 178, 83, 116, 46, 57, 52, 43, 203, 232, 113, 221, 213, 64, 199, 111, 38, 5, 62, 88, 67, 244, 14, 142, 234, 62, 161, 57, 216, 102, 239, 155, 56, 96, 115, 111, 95, 51, 138, 165, 102, 91, 168, 133, 56, 66, 131, 253, 169, 40, 119, 30 }, new byte[] { 206, 211, 239, 155, 20, 148, 105, 79, 195, 43, 225, 141, 170, 45, 102, 170, 22, 126, 180, 96, 56, 198, 242, 216, 3, 196, 218, 184, 115, 40, 53, 5, 255, 46, 42, 145, 126, 190, 87, 61, 141, 88, 0, 143, 27, 186, 140, 232, 122, 226, 33, 29, 10, 21, 43, 6, 4, 147, 142, 25, 166, 169, 155, 234, 116, 156, 36, 94, 104, 59, 83, 218, 83, 217, 232, 83, 81, 189, 182, 234, 115, 189, 212, 227, 86, 222, 202, 67, 177, 181, 60, 245, 176, 236, 39, 183, 113, 8, 155, 148, 216, 127, 115, 132, 10, 18, 100, 160, 29, 28, 131, 230, 148, 185, 29, 207, 119, 135, 89, 171, 110, 248, 11, 51, 207, 96, 167, 22 } });
        }
    }
}
