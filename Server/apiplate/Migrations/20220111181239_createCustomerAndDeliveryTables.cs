using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace apiplate.Migrations
{
    public partial class createCustomerAndDeliveryTables : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "CustomerId",
                table: "Notification",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "DeliveryDriverId",
                table: "Notification",
                type: "int",
                nullable: true);

            migrationBuilder.CreateTable(
                name: "Customers",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Location = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    LastUpdate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    CreatedBy = table.Column<int>(type: "int", nullable: true),
                    Username = table.Column<string>(type: "nvarchar(30)", maxLength: 30, nullable: false),
                    Email = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Phone = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    PasswordHash = table.Column<byte[]>(type: "varbinary(max)", nullable: false),
                    PasswordSalt = table.Column<byte[]>(type: "varbinary(max)", nullable: false),
                    Photo = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Customers", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "DeliveryDrivers",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    LastUpdate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    CreatedBy = table.Column<int>(type: "int", nullable: true),
                    Username = table.Column<string>(type: "nvarchar(30)", maxLength: 30, nullable: false),
                    Email = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Phone = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    PasswordHash = table.Column<byte[]>(type: "varbinary(max)", nullable: false),
                    PasswordSalt = table.Column<byte[]>(type: "varbinary(max)", nullable: false),
                    Photo = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DeliveryDrivers", x => x.Id);
                });

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "CreatedAt", "LastUpdate", "PasswordHash", "PasswordSalt" },
                values: new object[] { new DateTime(2022, 1, 11, 20, 12, 38, 424, DateTimeKind.Local).AddTicks(4494), new DateTime(2022, 1, 11, 20, 12, 38, 425, DateTimeKind.Local).AddTicks(6668), new byte[] { 106, 70, 66, 215, 160, 144, 155, 210, 148, 203, 182, 152, 25, 130, 74, 155, 34, 75, 56, 183, 189, 222, 220, 185, 48, 184, 82, 230, 192, 246, 232, 153, 240, 12, 27, 174, 182, 12, 180, 15, 134, 123, 222, 84, 58, 170, 119, 254, 132, 119, 87, 1, 12, 111, 96, 165, 138, 202, 197, 194, 120, 132, 45, 126 }, new byte[] { 236, 71, 43, 134, 208, 249, 138, 248, 14, 116, 75, 50, 89, 170, 175, 168, 223, 54, 122, 176, 203, 90, 17, 118, 206, 187, 181, 193, 126, 19, 148, 221, 44, 0, 183, 233, 13, 84, 230, 10, 195, 3, 49, 6, 216, 22, 77, 141, 121, 65, 16, 178, 136, 14, 17, 225, 97, 253, 205, 77, 94, 134, 158, 41, 83, 215, 200, 137, 138, 244, 133, 116, 134, 26, 201, 225, 64, 67, 79, 235, 108, 213, 90, 62, 110, 80, 62, 229, 228, 0, 247, 124, 79, 46, 82, 122, 158, 198, 21, 241, 54, 153, 226, 60, 94, 61, 174, 236, 107, 94, 65, 161, 252, 31, 9, 16, 185, 22, 46, 154, 241, 67, 251, 242, 192, 45, 169, 84 } });

            migrationBuilder.CreateIndex(
                name: "IX_Notification_CustomerId",
                table: "Notification",
                column: "CustomerId");

            migrationBuilder.CreateIndex(
                name: "IX_Notification_DeliveryDriverId",
                table: "Notification",
                column: "DeliveryDriverId");

            migrationBuilder.CreateIndex(
                name: "IX_Customers_Phone",
                table: "Customers",
                column: "Phone",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_DeliveryDrivers_Phone",
                table: "DeliveryDrivers",
                column: "Phone",
                unique: true);

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
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Notification_Customers_CustomerId",
                table: "Notification");

            migrationBuilder.DropForeignKey(
                name: "FK_Notification_DeliveryDrivers_DeliveryDriverId",
                table: "Notification");

            migrationBuilder.DropTable(
                name: "Customers");

            migrationBuilder.DropTable(
                name: "DeliveryDrivers");

            migrationBuilder.DropIndex(
                name: "IX_Notification_CustomerId",
                table: "Notification");

            migrationBuilder.DropIndex(
                name: "IX_Notification_DeliveryDriverId",
                table: "Notification");

            migrationBuilder.DropColumn(
                name: "CustomerId",
                table: "Notification");

            migrationBuilder.DropColumn(
                name: "DeliveryDriverId",
                table: "Notification");

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "CreatedAt", "LastUpdate", "PasswordHash", "PasswordSalt" },
                values: new object[] { new DateTime(2022, 1, 11, 20, 9, 28, 294, DateTimeKind.Local).AddTicks(3918), new DateTime(2022, 1, 11, 20, 9, 28, 295, DateTimeKind.Local).AddTicks(8767), new byte[] { 142, 123, 29, 47, 54, 233, 109, 223, 222, 182, 126, 84, 212, 73, 107, 40, 187, 217, 137, 124, 12, 104, 235, 224, 98, 3, 86, 105, 47, 255, 245, 72, 153, 101, 173, 62, 75, 186, 83, 76, 198, 191, 212, 92, 188, 173, 83, 163, 128, 45, 200, 188, 191, 15, 208, 254, 182, 61, 38, 234, 156, 0, 80, 210 }, new byte[] { 206, 73, 253, 89, 239, 176, 224, 221, 237, 182, 137, 5, 97, 67, 28, 155, 103, 66, 237, 183, 91, 234, 172, 131, 116, 159, 125, 168, 148, 20, 105, 11, 196, 64, 254, 62, 111, 195, 59, 119, 94, 119, 191, 8, 194, 66, 27, 218, 213, 60, 101, 182, 30, 166, 223, 108, 59, 136, 61, 109, 26, 130, 3, 145, 37, 183, 15, 72, 234, 113, 235, 228, 203, 16, 181, 59, 12, 220, 158, 7, 53, 104, 220, 138, 41, 73, 240, 50, 36, 27, 224, 139, 217, 232, 157, 130, 208, 208, 112, 120, 37, 136, 123, 100, 184, 4, 104, 252, 139, 5, 166, 39, 31, 81, 228, 111, 14, 140, 80, 37, 166, 201, 176, 223, 178, 241, 71, 170 } });
        }
    }
}
