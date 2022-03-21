using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace apiplate.Migrations
{
    public partial class addMeterPriceToBranch : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<double>(
                name: "PricePerMeter",
                table: "Branches",
                type: "float",
                nullable: false,
                defaultValue: 0.0);

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "CreatedAt", "LastUpdate", "PasswordHash", "PasswordSalt" },
                values: new object[] { new DateTime(2022, 3, 21, 10, 1, 49, 16, DateTimeKind.Local).AddTicks(8573), new DateTime(2022, 3, 21, 10, 1, 49, 26, DateTimeKind.Local).AddTicks(8061), new byte[] { 191, 49, 1, 75, 24, 86, 191, 244, 255, 47, 157, 164, 133, 100, 75, 145, 182, 94, 25, 135, 16, 155, 53, 156, 194, 105, 239, 252, 24, 168, 10, 222, 86, 155, 4, 182, 233, 252, 108, 194, 9, 181, 70, 171, 8, 127, 154, 109, 234, 187, 187, 197, 122, 62, 211, 237, 91, 135, 212, 243, 24, 80, 3, 137 }, new byte[] { 214, 0, 168, 244, 63, 125, 131, 27, 174, 193, 103, 153, 239, 190, 236, 35, 42, 21, 202, 248, 87, 183, 79, 49, 86, 73, 223, 36, 163, 193, 242, 158, 95, 82, 254, 90, 108, 36, 95, 199, 142, 154, 162, 108, 244, 219, 237, 157, 57, 69, 158, 92, 181, 217, 122, 92, 169, 132, 7, 130, 185, 11, 146, 132, 85, 96, 211, 88, 121, 68, 152, 77, 181, 7, 81, 146, 35, 178, 193, 1, 24, 146, 186, 140, 250, 168, 103, 118, 153, 73, 163, 147, 24, 218, 40, 66, 58, 207, 90, 236, 192, 92, 21, 250, 15, 123, 92, 28, 128, 236, 6, 7, 164, 99, 250, 186, 195, 246, 154, 46, 72, 201, 244, 234, 238, 34, 229, 18 } });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "PricePerMeter",
                table: "Branches");

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "CreatedAt", "LastUpdate", "PasswordHash", "PasswordSalt" },
                values: new object[] { new DateTime(2022, 1, 27, 21, 46, 56, 868, DateTimeKind.Local).AddTicks(6130), new DateTime(2022, 1, 27, 21, 46, 56, 870, DateTimeKind.Local).AddTicks(6163), new byte[] { 69, 9, 148, 169, 55, 10, 147, 85, 84, 14, 225, 106, 7, 148, 32, 45, 116, 231, 58, 122, 49, 177, 49, 107, 177, 195, 104, 253, 224, 84, 146, 51, 240, 31, 132, 6, 188, 47, 8, 156, 239, 237, 49, 93, 137, 242, 136, 176, 175, 129, 8, 196, 123, 106, 94, 17, 4, 244, 183, 61, 54, 97, 3, 3 }, new byte[] { 76, 161, 39, 17, 120, 251, 101, 209, 40, 40, 91, 56, 40, 140, 136, 186, 169, 102, 9, 94, 95, 52, 99, 91, 52, 203, 173, 181, 19, 249, 106, 76, 148, 166, 130, 4, 225, 102, 178, 47, 165, 38, 189, 227, 83, 185, 147, 83, 236, 128, 168, 176, 125, 42, 19, 14, 108, 234, 35, 112, 147, 26, 62, 62, 53, 239, 139, 222, 46, 22, 52, 30, 190, 146, 101, 24, 83, 250, 178, 23, 200, 109, 208, 29, 210, 104, 27, 70, 118, 55, 70, 203, 5, 110, 208, 202, 217, 117, 154, 215, 173, 243, 75, 156, 52, 191, 79, 242, 102, 115, 9, 180, 44, 179, 126, 245, 251, 142, 225, 48, 101, 121, 210, 201, 142, 224, 179, 92 } });
        }
    }
}
