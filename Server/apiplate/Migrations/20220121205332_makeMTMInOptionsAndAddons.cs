using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace apiplate.Migrations
{
    public partial class makeMTMInOptionsAndAddons : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Addons_Products_ProductId",
                table: "Addons");

            migrationBuilder.DropForeignKey(
                name: "FK_Options_Products_ProductId",
                table: "Options");

            migrationBuilder.DropIndex(
                name: "IX_Options_ProductId",
                table: "Options");

            migrationBuilder.DropIndex(
                name: "IX_Addons_ProductId",
                table: "Addons");

            migrationBuilder.DropColumn(
                name: "ProductId",
                table: "Options");

            migrationBuilder.DropColumn(
                name: "ProductId",
                table: "Addons");

            migrationBuilder.CreateTable(
                name: "AddOnProduct",
                columns: table => new
                {
                    AddOnsId = table.Column<int>(type: "int", nullable: false),
                    ProductsId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AddOnProduct", x => new { x.AddOnsId, x.ProductsId });
                    table.ForeignKey(
                        name: "FK_AddOnProduct_Addons_AddOnsId",
                        column: x => x.AddOnsId,
                        principalTable: "Addons",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_AddOnProduct_Products_ProductsId",
                        column: x => x.ProductsId,
                        principalTable: "Products",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "OptionProduct",
                columns: table => new
                {
                    OptionsId = table.Column<int>(type: "int", nullable: false),
                    ProductsId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_OptionProduct", x => new { x.OptionsId, x.ProductsId });
                    table.ForeignKey(
                        name: "FK_OptionProduct_Options_OptionsId",
                        column: x => x.OptionsId,
                        principalTable: "Options",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_OptionProduct_Products_ProductsId",
                        column: x => x.ProductsId,
                        principalTable: "Products",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "CreatedAt", "LastUpdate", "PasswordHash", "PasswordSalt" },
                values: new object[] { new DateTime(2022, 1, 21, 22, 53, 31, 496, DateTimeKind.Local).AddTicks(6952), new DateTime(2022, 1, 21, 22, 53, 31, 497, DateTimeKind.Local).AddTicks(8791), new byte[] { 42, 33, 59, 80, 135, 34, 41, 212, 124, 11, 64, 161, 70, 137, 134, 195, 32, 32, 32, 209, 115, 193, 69, 33, 138, 70, 34, 159, 213, 112, 250, 231, 233, 228, 115, 185, 58, 13, 214, 135, 152, 73, 14, 126, 111, 158, 58, 241, 26, 173, 186, 231, 210, 81, 120, 162, 130, 33, 238, 192, 118, 119, 124, 4 }, new byte[] { 203, 21, 121, 159, 203, 65, 121, 72, 64, 29, 203, 34, 156, 249, 249, 196, 45, 51, 57, 65, 54, 237, 204, 119, 127, 187, 104, 84, 79, 165, 78, 79, 73, 167, 35, 45, 100, 195, 170, 226, 0, 191, 144, 82, 126, 74, 197, 197, 136, 186, 75, 162, 182, 243, 93, 247, 6, 191, 232, 42, 222, 105, 127, 188, 189, 157, 232, 96, 119, 106, 201, 172, 251, 130, 22, 132, 112, 36, 42, 24, 78, 90, 31, 66, 237, 146, 213, 165, 70, 248, 103, 124, 125, 40, 135, 179, 23, 167, 30, 152, 79, 100, 113, 231, 187, 9, 141, 151, 248, 180, 126, 219, 175, 178, 3, 76, 46, 198, 155, 11, 155, 45, 175, 92, 122, 104, 42, 94 } });

            migrationBuilder.CreateIndex(
                name: "IX_AddOnProduct_ProductsId",
                table: "AddOnProduct",
                column: "ProductsId");

            migrationBuilder.CreateIndex(
                name: "IX_OptionProduct_ProductsId",
                table: "OptionProduct",
                column: "ProductsId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "AddOnProduct");

            migrationBuilder.DropTable(
                name: "OptionProduct");

            migrationBuilder.AddColumn<int>(
                name: "ProductId",
                table: "Options",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "ProductId",
                table: "Addons",
                type: "int",
                nullable: true);

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "CreatedAt", "LastUpdate", "PasswordHash", "PasswordSalt" },
                values: new object[] { new DateTime(2022, 1, 21, 22, 17, 5, 334, DateTimeKind.Local).AddTicks(819), new DateTime(2022, 1, 21, 22, 17, 5, 335, DateTimeKind.Local).AddTicks(3847), new byte[] { 125, 184, 134, 107, 254, 203, 210, 61, 134, 243, 92, 212, 168, 11, 19, 78, 19, 32, 88, 45, 215, 141, 125, 229, 127, 59, 199, 145, 209, 82, 101, 148, 169, 51, 231, 111, 217, 255, 236, 197, 200, 205, 199, 40, 211, 42, 177, 64, 195, 5, 23, 86, 224, 181, 14, 176, 151, 167, 186, 170, 184, 20, 150, 137 }, new byte[] { 204, 196, 142, 157, 11, 154, 83, 88, 226, 183, 28, 232, 135, 180, 142, 124, 253, 43, 213, 177, 231, 210, 165, 245, 201, 25, 134, 53, 114, 228, 30, 99, 224, 194, 145, 239, 181, 201, 25, 135, 43, 241, 39, 94, 148, 35, 162, 61, 196, 100, 129, 180, 169, 132, 6, 250, 65, 147, 36, 60, 60, 152, 90, 105, 167, 157, 58, 123, 172, 193, 252, 234, 230, 232, 17, 196, 16, 55, 29, 204, 8, 81, 202, 128, 188, 2, 130, 65, 51, 118, 11, 88, 66, 71, 18, 174, 60, 215, 76, 24, 181, 24, 167, 199, 156, 70, 20, 224, 232, 2, 39, 66, 10, 83, 45, 240, 170, 95, 235, 66, 242, 131, 84, 158, 22, 51, 181, 244 } });

            migrationBuilder.CreateIndex(
                name: "IX_Options_ProductId",
                table: "Options",
                column: "ProductId");

            migrationBuilder.CreateIndex(
                name: "IX_Addons_ProductId",
                table: "Addons",
                column: "ProductId");

            migrationBuilder.AddForeignKey(
                name: "FK_Addons_Products_ProductId",
                table: "Addons",
                column: "ProductId",
                principalTable: "Products",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "FK_Options_Products_ProductId",
                table: "Options",
                column: "ProductId",
                principalTable: "Products",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);
        }
    }
}
