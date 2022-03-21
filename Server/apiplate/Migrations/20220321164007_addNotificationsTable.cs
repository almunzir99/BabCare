using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace apiplate.Migrations
{
    public partial class addNotificationsTable : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Notification_Customers_CustomerId",
                table: "Notification");

            migrationBuilder.DropForeignKey(
                name: "FK_Notification_DeliveryDrivers_DeliveryDriverId",
                table: "Notification");

            migrationBuilder.DropForeignKey(
                name: "FK_Notification_Users_AdminId",
                table: "Notification");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Notification",
                table: "Notification");

            migrationBuilder.RenameTable(
                name: "Notification",
                newName: "Notifications");

            migrationBuilder.RenameIndex(
                name: "IX_Notification_DeliveryDriverId",
                table: "Notifications",
                newName: "IX_Notifications_DeliveryDriverId");

            migrationBuilder.RenameIndex(
                name: "IX_Notification_CustomerId",
                table: "Notifications",
                newName: "IX_Notifications_CustomerId");

            migrationBuilder.RenameIndex(
                name: "IX_Notification_AdminId",
                table: "Notifications",
                newName: "IX_Notifications_AdminId");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Notifications",
                table: "Notifications",
                column: "Id");

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "CreatedAt", "LastUpdate", "PasswordHash", "PasswordSalt" },
                values: new object[] { new DateTime(2022, 3, 21, 18, 40, 6, 246, DateTimeKind.Local).AddTicks(5994), new DateTime(2022, 3, 21, 18, 40, 6, 412, DateTimeKind.Local).AddTicks(2488), new byte[] { 119, 10, 95, 231, 29, 43, 99, 0, 73, 115, 51, 144, 172, 41, 104, 210, 32, 71, 94, 234, 152, 114, 112, 64, 100, 147, 13, 15, 188, 92, 223, 81, 87, 21, 227, 229, 218, 101, 242, 239, 151, 11, 82, 113, 253, 229, 204, 31, 250, 126, 246, 232, 60, 125, 218, 183, 214, 97, 72, 4, 131, 107, 206, 239 }, new byte[] { 70, 106, 17, 132, 11, 98, 116, 125, 7, 7, 183, 102, 172, 195, 142, 97, 18, 93, 128, 123, 225, 239, 76, 124, 55, 90, 189, 23, 66, 249, 91, 170, 160, 184, 19, 57, 189, 140, 132, 110, 146, 67, 247, 43, 139, 56, 57, 138, 99, 129, 229, 69, 46, 204, 112, 250, 53, 144, 86, 51, 92, 137, 5, 52, 203, 170, 38, 146, 147, 117, 172, 105, 221, 85, 3, 65, 255, 154, 63, 4, 88, 238, 109, 130, 65, 127, 33, 190, 134, 241, 165, 185, 245, 107, 177, 35, 21, 35, 25, 203, 116, 163, 208, 92, 9, 96, 35, 103, 210, 184, 19, 186, 28, 43, 244, 47, 41, 84, 186, 104, 185, 114, 36, 122, 67, 241, 158, 230 } });

            migrationBuilder.AddForeignKey(
                name: "FK_Notifications_Customers_CustomerId",
                table: "Notifications",
                column: "CustomerId",
                principalTable: "Customers",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "FK_Notifications_DeliveryDrivers_DeliveryDriverId",
                table: "Notifications",
                column: "DeliveryDriverId",
                principalTable: "DeliveryDrivers",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "FK_Notifications_Users_AdminId",
                table: "Notifications",
                column: "AdminId",
                principalTable: "Users",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Notifications_Customers_CustomerId",
                table: "Notifications");

            migrationBuilder.DropForeignKey(
                name: "FK_Notifications_DeliveryDrivers_DeliveryDriverId",
                table: "Notifications");

            migrationBuilder.DropForeignKey(
                name: "FK_Notifications_Users_AdminId",
                table: "Notifications");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Notifications",
                table: "Notifications");

            migrationBuilder.RenameTable(
                name: "Notifications",
                newName: "Notification");

            migrationBuilder.RenameIndex(
                name: "IX_Notifications_DeliveryDriverId",
                table: "Notification",
                newName: "IX_Notification_DeliveryDriverId");

            migrationBuilder.RenameIndex(
                name: "IX_Notifications_CustomerId",
                table: "Notification",
                newName: "IX_Notification_CustomerId");

            migrationBuilder.RenameIndex(
                name: "IX_Notifications_AdminId",
                table: "Notification",
                newName: "IX_Notification_AdminId");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Notification",
                table: "Notification",
                column: "Id");

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "CreatedAt", "LastUpdate", "PasswordHash", "PasswordSalt" },
                values: new object[] { new DateTime(2022, 3, 21, 10, 1, 49, 16, DateTimeKind.Local).AddTicks(8573), new DateTime(2022, 3, 21, 10, 1, 49, 26, DateTimeKind.Local).AddTicks(8061), new byte[] { 191, 49, 1, 75, 24, 86, 191, 244, 255, 47, 157, 164, 133, 100, 75, 145, 182, 94, 25, 135, 16, 155, 53, 156, 194, 105, 239, 252, 24, 168, 10, 222, 86, 155, 4, 182, 233, 252, 108, 194, 9, 181, 70, 171, 8, 127, 154, 109, 234, 187, 187, 197, 122, 62, 211, 237, 91, 135, 212, 243, 24, 80, 3, 137 }, new byte[] { 214, 0, 168, 244, 63, 125, 131, 27, 174, 193, 103, 153, 239, 190, 236, 35, 42, 21, 202, 248, 87, 183, 79, 49, 86, 73, 223, 36, 163, 193, 242, 158, 95, 82, 254, 90, 108, 36, 95, 199, 142, 154, 162, 108, 244, 219, 237, 157, 57, 69, 158, 92, 181, 217, 122, 92, 169, 132, 7, 130, 185, 11, 146, 132, 85, 96, 211, 88, 121, 68, 152, 77, 181, 7, 81, 146, 35, 178, 193, 1, 24, 146, 186, 140, 250, 168, 103, 118, 153, 73, 163, 147, 24, 218, 40, 66, 58, 207, 90, 236, 192, 92, 21, 250, 15, 123, 92, 28, 128, 236, 6, 7, 164, 99, 250, 186, 195, 246, 154, 46, 72, 201, 244, 234, 238, 34, 229, 18 } });

            migrationBuilder.AddForeignKey(
                name: "FK_Notification_Customers_CustomerId",
                table: "Notification",
                column: "CustomerId",
                principalTable: "Customers",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "FK_Notification_DeliveryDrivers_DeliveryDriverId",
                table: "Notification",
                column: "DeliveryDriverId",
                principalTable: "DeliveryDrivers",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "FK_Notification_Users_AdminId",
                table: "Notification",
                column: "AdminId",
                principalTable: "Users",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);
        }
    }
}
