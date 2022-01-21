using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace apiplate.Migrations
{
    public partial class createOfferTable : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "OfferId",
                table: "Categories",
                type: "int",
                nullable: true);

            migrationBuilder.CreateTable(
                name: "Offers",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Title = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    ImageId = table.Column<int>(type: "int", nullable: true),
                    CategoryId = table.Column<int>(type: "int", nullable: false),
                    StartDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    EndDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    LastUpdate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    CreatedBy = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Offers", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Offers_Categories_CategoryId",
                        column: x => x.CategoryId,
                        principalTable: "Categories",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Offers_Image_ImageId",
                        column: x => x.ImageId,
                        principalTable: "Image",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "CreatedAt", "LastUpdate", "PasswordHash", "PasswordSalt" },
                values: new object[] { new DateTime(2022, 1, 21, 21, 36, 47, 267, DateTimeKind.Local).AddTicks(4314), new DateTime(2022, 1, 21, 21, 36, 47, 268, DateTimeKind.Local).AddTicks(5376), new byte[] { 211, 55, 76, 153, 149, 142, 76, 92, 1, 242, 143, 80, 230, 241, 13, 60, 94, 160, 149, 90, 40, 113, 18, 211, 69, 155, 154, 102, 208, 241, 125, 225, 60, 159, 28, 61, 230, 63, 142, 26, 29, 207, 7, 187, 5, 125, 171, 9, 99, 147, 44, 133, 217, 99, 91, 85, 62, 120, 39, 84, 162, 192, 26, 195 }, new byte[] { 58, 129, 23, 215, 176, 53, 139, 167, 225, 152, 21, 68, 104, 223, 241, 164, 202, 81, 160, 153, 201, 21, 22, 254, 244, 149, 144, 216, 254, 210, 61, 128, 242, 200, 227, 128, 176, 207, 81, 5, 201, 189, 23, 143, 140, 20, 29, 163, 34, 147, 246, 209, 58, 19, 152, 166, 8, 228, 77, 221, 122, 235, 76, 227, 96, 134, 227, 155, 139, 174, 28, 35, 92, 51, 102, 252, 136, 15, 212, 25, 83, 149, 114, 234, 147, 80, 21, 18, 120, 234, 33, 109, 152, 25, 28, 253, 222, 209, 223, 130, 54, 42, 162, 169, 24, 185, 201, 74, 29, 249, 57, 83, 63, 5, 15, 57, 150, 34, 121, 53, 231, 60, 48, 17, 110, 36, 111, 13 } });

            migrationBuilder.CreateIndex(
                name: "IX_Categories_OfferId",
                table: "Categories",
                column: "OfferId");

            migrationBuilder.CreateIndex(
                name: "IX_Offers_CategoryId",
                table: "Offers",
                column: "CategoryId");

            migrationBuilder.CreateIndex(
                name: "IX_Offers_ImageId",
                table: "Offers",
                column: "ImageId");

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

            migrationBuilder.DropTable(
                name: "Offers");

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
                values: new object[] { new DateTime(2022, 1, 20, 19, 17, 3, 409, DateTimeKind.Local).AddTicks(1152), new DateTime(2022, 1, 20, 19, 17, 3, 410, DateTimeKind.Local).AddTicks(4024), new byte[] { 24, 156, 211, 129, 219, 102, 253, 172, 117, 230, 28, 23, 210, 116, 234, 60, 192, 19, 82, 109, 94, 32, 196, 162, 67, 208, 88, 99, 148, 221, 116, 213, 12, 170, 163, 57, 133, 146, 254, 103, 156, 245, 160, 228, 205, 221, 101, 138, 57, 31, 94, 86, 82, 68, 6, 102, 80, 113, 104, 5, 210, 42, 150, 5 }, new byte[] { 96, 1, 89, 50, 121, 145, 33, 178, 245, 18, 212, 26, 102, 60, 132, 40, 23, 17, 202, 181, 90, 210, 235, 247, 179, 220, 177, 43, 102, 14, 27, 220, 77, 134, 188, 186, 16, 88, 99, 62, 75, 220, 114, 190, 63, 118, 150, 75, 81, 116, 190, 92, 220, 101, 215, 46, 13, 117, 42, 153, 10, 9, 48, 49, 132, 203, 5, 194, 104, 210, 228, 41, 65, 200, 127, 86, 8, 187, 187, 93, 143, 0, 237, 149, 69, 113, 110, 9, 89, 250, 104, 133, 8, 32, 94, 126, 157, 52, 169, 255, 35, 183, 70, 31, 237, 145, 135, 62, 153, 90, 151, 28, 124, 118, 165, 32, 152, 136, 154, 119, 35, 209, 130, 143, 213, 145, 37, 151 } });
        }
    }
}
