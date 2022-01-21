using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace apiplate.Migrations
{
    public partial class addOfferPermissionToRoles : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "OffersPermissonId",
                table: "Roles",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "OrdersPermissonId",
                table: "Roles",
                type: "int",
                nullable: true);

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "CreatedAt", "LastUpdate", "PasswordHash", "PasswordSalt" },
                values: new object[] { new DateTime(2022, 1, 21, 21, 43, 7, 636, DateTimeKind.Local).AddTicks(1254), new DateTime(2022, 1, 21, 21, 43, 7, 637, DateTimeKind.Local).AddTicks(3275), new byte[] { 153, 116, 144, 151, 244, 6, 18, 75, 214, 51, 150, 5, 27, 197, 186, 15, 204, 58, 39, 104, 185, 204, 63, 185, 220, 162, 33, 81, 232, 59, 44, 7, 115, 217, 89, 7, 155, 74, 36, 169, 235, 225, 121, 218, 163, 45, 45, 189, 113, 119, 149, 144, 239, 208, 107, 85, 104, 58, 84, 250, 205, 180, 83, 88 }, new byte[] { 105, 251, 241, 47, 213, 21, 66, 197, 212, 6, 153, 192, 168, 65, 145, 90, 240, 234, 168, 85, 247, 20, 46, 124, 250, 17, 149, 149, 1, 143, 69, 195, 200, 92, 152, 218, 81, 92, 56, 180, 56, 178, 210, 35, 43, 19, 216, 42, 48, 115, 59, 74, 212, 145, 48, 128, 116, 163, 137, 49, 152, 92, 252, 56, 87, 201, 44, 3, 184, 178, 30, 165, 26, 117, 184, 61, 174, 166, 157, 222, 32, 232, 34, 229, 16, 250, 239, 78, 249, 159, 124, 221, 179, 209, 0, 144, 22, 104, 171, 221, 40, 246, 235, 208, 87, 60, 251, 250, 182, 247, 65, 98, 78, 154, 215, 82, 120, 48, 163, 168, 41, 233, 48, 108, 170, 163, 173, 230 } });

            migrationBuilder.CreateIndex(
                name: "IX_Roles_OffersPermissonId",
                table: "Roles",
                column: "OffersPermissonId");

            migrationBuilder.CreateIndex(
                name: "IX_Roles_OrdersPermissonId",
                table: "Roles",
                column: "OrdersPermissonId");

            migrationBuilder.AddForeignKey(
                name: "FK_Roles_Permissions_OffersPermissonId",
                table: "Roles",
                column: "OffersPermissonId",
                principalTable: "Permissions",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "FK_Roles_Permissions_OrdersPermissonId",
                table: "Roles",
                column: "OrdersPermissonId",
                principalTable: "Permissions",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Roles_Permissions_OffersPermissonId",
                table: "Roles");

            migrationBuilder.DropForeignKey(
                name: "FK_Roles_Permissions_OrdersPermissonId",
                table: "Roles");

            migrationBuilder.DropIndex(
                name: "IX_Roles_OffersPermissonId",
                table: "Roles");

            migrationBuilder.DropIndex(
                name: "IX_Roles_OrdersPermissonId",
                table: "Roles");

            migrationBuilder.DropColumn(
                name: "OffersPermissonId",
                table: "Roles");

            migrationBuilder.DropColumn(
                name: "OrdersPermissonId",
                table: "Roles");

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "CreatedAt", "LastUpdate", "PasswordHash", "PasswordSalt" },
                values: new object[] { new DateTime(2022, 1, 21, 21, 36, 47, 267, DateTimeKind.Local).AddTicks(4314), new DateTime(2022, 1, 21, 21, 36, 47, 268, DateTimeKind.Local).AddTicks(5376), new byte[] { 211, 55, 76, 153, 149, 142, 76, 92, 1, 242, 143, 80, 230, 241, 13, 60, 94, 160, 149, 90, 40, 113, 18, 211, 69, 155, 154, 102, 208, 241, 125, 225, 60, 159, 28, 61, 230, 63, 142, 26, 29, 207, 7, 187, 5, 125, 171, 9, 99, 147, 44, 133, 217, 99, 91, 85, 62, 120, 39, 84, 162, 192, 26, 195 }, new byte[] { 58, 129, 23, 215, 176, 53, 139, 167, 225, 152, 21, 68, 104, 223, 241, 164, 202, 81, 160, 153, 201, 21, 22, 254, 244, 149, 144, 216, 254, 210, 61, 128, 242, 200, 227, 128, 176, 207, 81, 5, 201, 189, 23, 143, 140, 20, 29, 163, 34, 147, 246, 209, 58, 19, 152, 166, 8, 228, 77, 221, 122, 235, 76, 227, 96, 134, 227, 155, 139, 174, 28, 35, 92, 51, 102, 252, 136, 15, 212, 25, 83, 149, 114, 234, 147, 80, 21, 18, 120, 234, 33, 109, 152, 25, 28, 253, 222, 209, 223, 130, 54, 42, 162, 169, 24, 185, 201, 74, 29, 249, 57, 83, 63, 5, 15, 57, 150, 34, 121, 53, 231, 60, 48, 17, 110, 36, 111, 13 } });
        }
    }
}
