using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace apiplate.Migrations
{
    public partial class addProductAndCategoriesPermissionToRoles : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "CategoriesPermissonId",
                table: "Roles",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "ProductsPermissonId",
                table: "Roles",
                type: "int",
                nullable: true);

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "CreatedAt", "LastUpdate", "PasswordHash", "PasswordSalt" },
                values: new object[] { new DateTime(2022, 1, 12, 19, 57, 7, 446, DateTimeKind.Local).AddTicks(9203), new DateTime(2022, 1, 12, 19, 57, 7, 448, DateTimeKind.Local).AddTicks(8), new byte[] { 186, 30, 165, 48, 216, 119, 218, 79, 221, 234, 18, 95, 175, 238, 100, 72, 176, 240, 151, 88, 103, 182, 51, 175, 180, 221, 241, 95, 9, 243, 227, 100, 79, 108, 71, 182, 201, 143, 170, 9, 130, 48, 140, 218, 105, 20, 176, 10, 184, 189, 181, 194, 2, 86, 237, 177, 26, 49, 167, 21, 203, 146, 147, 224 }, new byte[] { 5, 99, 187, 34, 80, 33, 67, 252, 116, 147, 201, 158, 179, 29, 12, 93, 33, 204, 203, 146, 143, 107, 213, 156, 229, 233, 56, 123, 217, 146, 19, 189, 87, 167, 199, 219, 224, 235, 207, 203, 118, 123, 56, 247, 130, 186, 70, 59, 174, 0, 49, 183, 152, 255, 63, 158, 57, 222, 24, 150, 205, 2, 27, 238, 107, 254, 199, 76, 209, 74, 222, 173, 151, 91, 103, 54, 185, 75, 128, 138, 188, 173, 108, 236, 234, 136, 139, 30, 18, 19, 99, 0, 242, 103, 76, 65, 150, 131, 60, 2, 49, 66, 92, 56, 26, 55, 240, 54, 138, 33, 88, 206, 12, 67, 243, 101, 68, 208, 80, 123, 78, 197, 93, 218, 136, 181, 159, 181 } });

            migrationBuilder.CreateIndex(
                name: "IX_Roles_CategoriesPermissonId",
                table: "Roles",
                column: "CategoriesPermissonId");

            migrationBuilder.CreateIndex(
                name: "IX_Roles_ProductsPermissonId",
                table: "Roles",
                column: "ProductsPermissonId");

            migrationBuilder.AddForeignKey(
                name: "FK_Roles_Permissions_CategoriesPermissonId",
                table: "Roles",
                column: "CategoriesPermissonId",
                principalTable: "Permissions",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "FK_Roles_Permissions_ProductsPermissonId",
                table: "Roles",
                column: "ProductsPermissonId",
                principalTable: "Permissions",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Roles_Permissions_CategoriesPermissonId",
                table: "Roles");

            migrationBuilder.DropForeignKey(
                name: "FK_Roles_Permissions_ProductsPermissonId",
                table: "Roles");

            migrationBuilder.DropIndex(
                name: "IX_Roles_CategoriesPermissonId",
                table: "Roles");

            migrationBuilder.DropIndex(
                name: "IX_Roles_ProductsPermissonId",
                table: "Roles");

            migrationBuilder.DropColumn(
                name: "CategoriesPermissonId",
                table: "Roles");

            migrationBuilder.DropColumn(
                name: "ProductsPermissonId",
                table: "Roles");

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "CreatedAt", "LastUpdate", "PasswordHash", "PasswordSalt" },
                values: new object[] { new DateTime(2022, 1, 12, 18, 8, 51, 884, DateTimeKind.Local).AddTicks(8642), new DateTime(2022, 1, 12, 18, 8, 51, 886, DateTimeKind.Local).AddTicks(348), new byte[] { 43, 160, 184, 161, 12, 224, 150, 186, 234, 96, 244, 242, 62, 212, 222, 44, 206, 170, 171, 162, 226, 30, 242, 64, 38, 185, 0, 56, 68, 248, 236, 34, 139, 235, 9, 116, 182, 17, 63, 74, 199, 214, 238, 63, 84, 97, 206, 92, 119, 112, 136, 195, 246, 181, 235, 171, 232, 231, 53, 104, 104, 255, 59, 1 }, new byte[] { 15, 158, 82, 123, 127, 171, 36, 16, 120, 150, 190, 0, 151, 165, 228, 127, 20, 43, 89, 89, 54, 151, 226, 6, 227, 100, 249, 163, 141, 189, 233, 0, 202, 32, 30, 65, 200, 249, 88, 149, 202, 238, 89, 141, 219, 221, 195, 146, 164, 104, 185, 237, 27, 4, 61, 3, 87, 116, 116, 13, 37, 115, 103, 195, 63, 197, 51, 20, 226, 30, 99, 242, 218, 158, 84, 208, 228, 8, 99, 249, 158, 104, 109, 54, 129, 249, 39, 118, 214, 124, 79, 79, 241, 202, 83, 127, 171, 134, 35, 140, 32, 96, 202, 11, 151, 180, 13, 37, 162, 227, 88, 221, 94, 101, 27, 18, 210, 255, 79, 171, 114, 111, 170, 34, 10, 158, 169, 220 } });
        }
    }
}
