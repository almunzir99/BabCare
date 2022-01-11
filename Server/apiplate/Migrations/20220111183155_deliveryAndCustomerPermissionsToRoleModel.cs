using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace apiplate.Migrations
{
    public partial class deliveryAndCustomerPermissionsToRoleModel : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "CustomersPermissionsId",
                table: "Roles",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "DeliveryPermissionsId",
                table: "Roles",
                type: "int",
                nullable: true);

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "CreatedAt", "LastUpdate", "PasswordHash", "PasswordSalt" },
                values: new object[] { new DateTime(2022, 1, 11, 20, 31, 54, 289, DateTimeKind.Local).AddTicks(5), new DateTime(2022, 1, 11, 20, 31, 54, 290, DateTimeKind.Local).AddTicks(1519), new byte[] { 114, 208, 197, 86, 227, 34, 151, 78, 183, 73, 230, 106, 86, 150, 195, 174, 53, 30, 166, 236, 110, 41, 17, 141, 230, 52, 28, 229, 153, 14, 7, 12, 43, 140, 61, 114, 115, 249, 119, 74, 106, 254, 77, 15, 53, 168, 133, 224, 27, 99, 24, 164, 94, 37, 161, 17, 48, 74, 185, 55, 242, 26, 197, 77 }, new byte[] { 0, 160, 94, 6, 75, 119, 195, 42, 67, 196, 169, 139, 42, 68, 35, 24, 75, 131, 10, 228, 118, 169, 15, 194, 196, 234, 184, 174, 138, 38, 147, 151, 165, 217, 249, 116, 25, 25, 0, 73, 230, 108, 49, 249, 5, 214, 18, 27, 122, 71, 240, 232, 220, 143, 163, 57, 78, 240, 204, 235, 163, 103, 81, 191, 2, 244, 248, 169, 116, 220, 174, 109, 176, 143, 237, 50, 7, 113, 56, 20, 220, 88, 128, 12, 69, 50, 240, 60, 99, 191, 27, 105, 181, 12, 180, 2, 176, 64, 26, 188, 104, 204, 84, 176, 5, 40, 68, 28, 206, 223, 109, 155, 213, 41, 24, 246, 206, 199, 207, 33, 6, 243, 84, 79, 67, 5, 95, 181 } });

            migrationBuilder.CreateIndex(
                name: "IX_Roles_CustomersPermissionsId",
                table: "Roles",
                column: "CustomersPermissionsId");

            migrationBuilder.CreateIndex(
                name: "IX_Roles_DeliveryPermissionsId",
                table: "Roles",
                column: "DeliveryPermissionsId");

            migrationBuilder.AddForeignKey(
                name: "FK_Roles_Permissions_CustomersPermissionsId",
                table: "Roles",
                column: "CustomersPermissionsId",
                principalTable: "Permissions",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "FK_Roles_Permissions_DeliveryPermissionsId",
                table: "Roles",
                column: "DeliveryPermissionsId",
                principalTable: "Permissions",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Roles_Permissions_CustomersPermissionsId",
                table: "Roles");

            migrationBuilder.DropForeignKey(
                name: "FK_Roles_Permissions_DeliveryPermissionsId",
                table: "Roles");

            migrationBuilder.DropIndex(
                name: "IX_Roles_CustomersPermissionsId",
                table: "Roles");

            migrationBuilder.DropIndex(
                name: "IX_Roles_DeliveryPermissionsId",
                table: "Roles");

            migrationBuilder.DropColumn(
                name: "CustomersPermissionsId",
                table: "Roles");

            migrationBuilder.DropColumn(
                name: "DeliveryPermissionsId",
                table: "Roles");

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "CreatedAt", "LastUpdate", "PasswordHash", "PasswordSalt" },
                values: new object[] { new DateTime(2022, 1, 11, 20, 12, 38, 424, DateTimeKind.Local).AddTicks(4494), new DateTime(2022, 1, 11, 20, 12, 38, 425, DateTimeKind.Local).AddTicks(6668), new byte[] { 106, 70, 66, 215, 160, 144, 155, 210, 148, 203, 182, 152, 25, 130, 74, 155, 34, 75, 56, 183, 189, 222, 220, 185, 48, 184, 82, 230, 192, 246, 232, 153, 240, 12, 27, 174, 182, 12, 180, 15, 134, 123, 222, 84, 58, 170, 119, 254, 132, 119, 87, 1, 12, 111, 96, 165, 138, 202, 197, 194, 120, 132, 45, 126 }, new byte[] { 236, 71, 43, 134, 208, 249, 138, 248, 14, 116, 75, 50, 89, 170, 175, 168, 223, 54, 122, 176, 203, 90, 17, 118, 206, 187, 181, 193, 126, 19, 148, 221, 44, 0, 183, 233, 13, 84, 230, 10, 195, 3, 49, 6, 216, 22, 77, 141, 121, 65, 16, 178, 136, 14, 17, 225, 97, 253, 205, 77, 94, 134, 158, 41, 83, 215, 200, 137, 138, 244, 133, 116, 134, 26, 201, 225, 64, 67, 79, 235, 108, 213, 90, 62, 110, 80, 62, 229, 228, 0, 247, 124, 79, 46, 82, 122, 158, 198, 21, 241, 54, 153, 226, 60, 94, 61, 174, 236, 107, 94, 65, 161, 252, 31, 9, 16, 185, 22, 46, 154, 241, 67, 251, 242, 192, 45, 169, 84 } });
        }
    }
}
