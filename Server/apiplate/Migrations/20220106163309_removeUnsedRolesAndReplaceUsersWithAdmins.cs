using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace apiplate.Migrations
{
    public partial class removeUnsedRolesAndReplaceUsersWithAdmins : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Roles_Permissions_EventsPermissionsId",
                table: "Roles");

            migrationBuilder.DropForeignKey(
                name: "FK_Roles_Permissions_NewsPermissionsId",
                table: "Roles");

            migrationBuilder.DropForeignKey(
                name: "FK_Roles_Permissions_ProgramsPermissionsId",
                table: "Roles");

            migrationBuilder.DropForeignKey(
                name: "FK_Roles_Permissions_SlidesPermissionsId",
                table: "Roles");

            migrationBuilder.DropForeignKey(
                name: "FK_Roles_Permissions_UsersPermissionsId",
                table: "Roles");

            migrationBuilder.DropIndex(
                name: "IX_Roles_EventsPermissionsId",
                table: "Roles");

            migrationBuilder.DropIndex(
                name: "IX_Roles_NewsPermissionsId",
                table: "Roles");

            migrationBuilder.DropIndex(
                name: "IX_Roles_ProgramsPermissionsId",
                table: "Roles");

            migrationBuilder.DropIndex(
                name: "IX_Roles_SlidesPermissionsId",
                table: "Roles");

            migrationBuilder.DropColumn(
                name: "EventsPermissionsId",
                table: "Roles");

            migrationBuilder.DropColumn(
                name: "NewsPermissionsId",
                table: "Roles");

            migrationBuilder.DropColumn(
                name: "ProgramsPermissionsId",
                table: "Roles");

            migrationBuilder.DropColumn(
                name: "SlidesPermissionsId",
                table: "Roles");

            migrationBuilder.RenameColumn(
                name: "UsersPermissionsId",
                table: "Roles",
                newName: "AdminsPermissionsId");

            migrationBuilder.RenameIndex(
                name: "IX_Roles_UsersPermissionsId",
                table: "Roles",
                newName: "IX_Roles_AdminsPermissionsId");

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "CreatedAt", "LastUpdate", "PasswordHash", "PasswordSalt" },
                values: new object[] { new DateTime(2022, 1, 6, 18, 33, 8, 567, DateTimeKind.Local).AddTicks(3500), new DateTime(2022, 1, 6, 18, 33, 8, 568, DateTimeKind.Local).AddTicks(4075), new byte[] { 65, 198, 130, 34, 178, 7, 202, 175, 141, 161, 158, 192, 93, 209, 225, 11, 209, 142, 164, 62, 162, 104, 7, 97, 169, 99, 117, 190, 220, 107, 34, 130, 153, 70, 121, 248, 131, 28, 237, 52, 155, 4, 100, 141, 112, 254, 254, 233, 175, 183, 184, 150, 4, 111, 208, 235, 67, 23, 171, 195, 115, 237, 3, 160 }, new byte[] { 25, 76, 222, 21, 73, 245, 201, 36, 78, 153, 159, 213, 88, 183, 2, 174, 114, 76, 159, 41, 173, 138, 167, 17, 113, 6, 112, 223, 168, 115, 119, 183, 171, 251, 135, 232, 51, 188, 150, 201, 44, 129, 107, 117, 4, 27, 22, 53, 229, 8, 98, 89, 187, 96, 156, 149, 55, 123, 159, 65, 159, 70, 184, 230, 44, 121, 20, 122, 46, 205, 247, 228, 209, 38, 179, 222, 105, 0, 1, 97, 67, 47, 125, 252, 100, 162, 213, 53, 103, 79, 172, 253, 55, 3, 10, 207, 146, 251, 101, 53, 16, 27, 122, 251, 78, 30, 88, 43, 15, 82, 93, 101, 25, 20, 118, 98, 245, 138, 212, 71, 170, 71, 171, 211, 170, 43, 97, 34 } });

            migrationBuilder.AddForeignKey(
                name: "FK_Roles_Permissions_AdminsPermissionsId",
                table: "Roles",
                column: "AdminsPermissionsId",
                principalTable: "Permissions",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Roles_Permissions_AdminsPermissionsId",
                table: "Roles");

            migrationBuilder.RenameColumn(
                name: "AdminsPermissionsId",
                table: "Roles",
                newName: "UsersPermissionsId");

            migrationBuilder.RenameIndex(
                name: "IX_Roles_AdminsPermissionsId",
                table: "Roles",
                newName: "IX_Roles_UsersPermissionsId");

            migrationBuilder.AddColumn<int>(
                name: "EventsPermissionsId",
                table: "Roles",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "NewsPermissionsId",
                table: "Roles",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "ProgramsPermissionsId",
                table: "Roles",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "SlidesPermissionsId",
                table: "Roles",
                type: "int",
                nullable: true);

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "CreatedAt", "LastUpdate", "PasswordHash", "PasswordSalt" },
                values: new object[] { new DateTime(2022, 1, 6, 18, 20, 18, 110, DateTimeKind.Local).AddTicks(3773), new DateTime(2022, 1, 6, 18, 20, 18, 111, DateTimeKind.Local).AddTicks(8221), new byte[] { 165, 2, 55, 83, 223, 245, 222, 223, 164, 107, 65, 159, 237, 100, 82, 6, 180, 144, 156, 105, 155, 177, 108, 80, 49, 236, 219, 255, 86, 151, 159, 224, 52, 210, 237, 50, 70, 46, 218, 19, 29, 23, 4, 79, 241, 74, 185, 237, 4, 212, 15, 163, 151, 166, 31, 120, 104, 199, 107, 196, 246, 233, 21, 154 }, new byte[] { 60, 26, 225, 39, 255, 76, 189, 38, 189, 153, 232, 113, 224, 121, 163, 16, 53, 241, 113, 130, 205, 145, 155, 219, 50, 95, 60, 28, 134, 180, 99, 43, 191, 67, 149, 55, 142, 88, 136, 255, 81, 26, 6, 227, 133, 236, 57, 164, 90, 161, 194, 173, 206, 157, 32, 95, 103, 127, 208, 148, 194, 96, 139, 241, 95, 173, 59, 42, 12, 159, 184, 15, 232, 131, 128, 244, 205, 77, 120, 198, 212, 27, 54, 188, 97, 170, 177, 126, 35, 46, 15, 172, 183, 44, 13, 10, 55, 121, 95, 18, 135, 185, 171, 117, 32, 210, 41, 101, 0, 190, 63, 107, 111, 8, 18, 123, 127, 82, 103, 66, 69, 128, 188, 5, 169, 174, 0, 209 } });

            migrationBuilder.CreateIndex(
                name: "IX_Roles_EventsPermissionsId",
                table: "Roles",
                column: "EventsPermissionsId");

            migrationBuilder.CreateIndex(
                name: "IX_Roles_NewsPermissionsId",
                table: "Roles",
                column: "NewsPermissionsId");

            migrationBuilder.CreateIndex(
                name: "IX_Roles_ProgramsPermissionsId",
                table: "Roles",
                column: "ProgramsPermissionsId");

            migrationBuilder.CreateIndex(
                name: "IX_Roles_SlidesPermissionsId",
                table: "Roles",
                column: "SlidesPermissionsId");

            migrationBuilder.AddForeignKey(
                name: "FK_Roles_Permissions_EventsPermissionsId",
                table: "Roles",
                column: "EventsPermissionsId",
                principalTable: "Permissions",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "FK_Roles_Permissions_NewsPermissionsId",
                table: "Roles",
                column: "NewsPermissionsId",
                principalTable: "Permissions",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "FK_Roles_Permissions_ProgramsPermissionsId",
                table: "Roles",
                column: "ProgramsPermissionsId",
                principalTable: "Permissions",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "FK_Roles_Permissions_SlidesPermissionsId",
                table: "Roles",
                column: "SlidesPermissionsId",
                principalTable: "Permissions",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "FK_Roles_Permissions_UsersPermissionsId",
                table: "Roles",
                column: "UsersPermissionsId",
                principalTable: "Permissions",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);
        }
    }
}
