using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace apiplate.Migrations
{
    public partial class addBranchesPermissions : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "BranchesPermissonId",
                table: "Roles",
                type: "int",
                nullable: true);

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "CreatedAt", "LastUpdate", "PasswordHash", "PasswordSalt" },
                values: new object[] { new DateTime(2022, 1, 15, 18, 31, 34, 458, DateTimeKind.Local).AddTicks(294), new DateTime(2022, 1, 15, 18, 31, 34, 459, DateTimeKind.Local).AddTicks(2318), new byte[] { 0, 15, 253, 158, 102, 196, 69, 54, 175, 161, 227, 4, 81, 174, 25, 167, 32, 27, 106, 2, 18, 74, 252, 8, 223, 223, 198, 165, 176, 245, 39, 239, 116, 28, 152, 219, 217, 54, 21, 111, 18, 7, 155, 95, 246, 185, 42, 64, 57, 119, 237, 127, 72, 93, 231, 28, 247, 74, 99, 127, 232, 116, 110, 211 }, new byte[] { 241, 70, 101, 155, 64, 244, 24, 103, 136, 1, 203, 241, 226, 95, 28, 51, 211, 27, 228, 255, 134, 59, 133, 230, 175, 162, 101, 15, 230, 152, 61, 64, 200, 89, 165, 26, 13, 167, 193, 63, 213, 152, 44, 117, 163, 93, 153, 165, 17, 81, 214, 94, 27, 140, 196, 1, 94, 227, 179, 50, 248, 217, 207, 200, 103, 0, 244, 170, 250, 153, 78, 109, 21, 155, 65, 74, 199, 158, 30, 162, 247, 119, 203, 126, 217, 72, 38, 190, 247, 253, 234, 144, 11, 85, 108, 58, 119, 151, 140, 202, 118, 48, 56, 89, 234, 101, 13, 143, 200, 3, 178, 238, 123, 128, 225, 228, 245, 255, 142, 160, 209, 252, 1, 107, 174, 232, 101, 251 } });

            migrationBuilder.CreateIndex(
                name: "IX_Roles_BranchesPermissonId",
                table: "Roles",
                column: "BranchesPermissonId");

            migrationBuilder.AddForeignKey(
                name: "FK_Roles_Permissions_BranchesPermissonId",
                table: "Roles",
                column: "BranchesPermissonId",
                principalTable: "Permissions",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Roles_Permissions_BranchesPermissonId",
                table: "Roles");

            migrationBuilder.DropIndex(
                name: "IX_Roles_BranchesPermissonId",
                table: "Roles");

            migrationBuilder.DropColumn(
                name: "BranchesPermissonId",
                table: "Roles");

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "CreatedAt", "LastUpdate", "PasswordHash", "PasswordSalt" },
                values: new object[] { new DateTime(2022, 1, 15, 15, 37, 16, 89, DateTimeKind.Local).AddTicks(8015), new DateTime(2022, 1, 15, 15, 37, 16, 92, DateTimeKind.Local).AddTicks(5765), new byte[] { 207, 197, 43, 178, 230, 244, 7, 101, 25, 228, 80, 127, 110, 38, 174, 72, 207, 26, 147, 246, 19, 43, 196, 28, 103, 122, 168, 203, 113, 75, 41, 111, 213, 182, 45, 88, 152, 230, 107, 58, 64, 239, 89, 112, 2, 64, 211, 216, 118, 195, 208, 173, 226, 51, 36, 177, 115, 215, 22, 24, 123, 165, 214, 247 }, new byte[] { 87, 138, 140, 30, 33, 174, 253, 37, 103, 64, 211, 43, 173, 185, 76, 64, 194, 220, 82, 9, 116, 40, 81, 229, 237, 92, 248, 66, 39, 111, 24, 151, 103, 98, 66, 203, 159, 179, 187, 110, 95, 27, 210, 114, 74, 92, 36, 8, 64, 143, 193, 38, 150, 177, 237, 185, 6, 152, 41, 17, 181, 250, 61, 145, 101, 52, 115, 181, 125, 27, 20, 14, 120, 29, 145, 61, 88, 39, 143, 188, 76, 213, 85, 254, 60, 236, 72, 250, 244, 167, 29, 255, 200, 217, 50, 166, 38, 66, 69, 159, 186, 62, 33, 11, 34, 212, 169, 61, 161, 184, 48, 96, 70, 233, 70, 125, 250, 239, 96, 190, 212, 79, 13, 69, 52, 31, 209, 137 } });
        }
    }
}
