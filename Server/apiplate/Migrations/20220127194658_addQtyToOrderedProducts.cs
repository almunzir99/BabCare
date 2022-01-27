using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace apiplate.Migrations
{
    public partial class addQtyToOrderedProducts : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "Quantity",
                table: "OrderedProducts",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "CreatedAt", "LastUpdate", "PasswordHash", "PasswordSalt" },
                values: new object[] { new DateTime(2022, 1, 27, 21, 46, 56, 868, DateTimeKind.Local).AddTicks(6130), new DateTime(2022, 1, 27, 21, 46, 56, 870, DateTimeKind.Local).AddTicks(6163), new byte[] { 69, 9, 148, 169, 55, 10, 147, 85, 84, 14, 225, 106, 7, 148, 32, 45, 116, 231, 58, 122, 49, 177, 49, 107, 177, 195, 104, 253, 224, 84, 146, 51, 240, 31, 132, 6, 188, 47, 8, 156, 239, 237, 49, 93, 137, 242, 136, 176, 175, 129, 8, 196, 123, 106, 94, 17, 4, 244, 183, 61, 54, 97, 3, 3 }, new byte[] { 76, 161, 39, 17, 120, 251, 101, 209, 40, 40, 91, 56, 40, 140, 136, 186, 169, 102, 9, 94, 95, 52, 99, 91, 52, 203, 173, 181, 19, 249, 106, 76, 148, 166, 130, 4, 225, 102, 178, 47, 165, 38, 189, 227, 83, 185, 147, 83, 236, 128, 168, 176, 125, 42, 19, 14, 108, 234, 35, 112, 147, 26, 62, 62, 53, 239, 139, 222, 46, 22, 52, 30, 190, 146, 101, 24, 83, 250, 178, 23, 200, 109, 208, 29, 210, 104, 27, 70, 118, 55, 70, 203, 5, 110, 208, 202, 217, 117, 154, 215, 173, 243, 75, 156, 52, 191, 79, 242, 102, 115, 9, 180, 44, 179, 126, 245, 251, 142, 225, 48, 101, 121, 210, 201, 142, 224, 179, 92 } });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Quantity",
                table: "OrderedProducts");

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "CreatedAt", "LastUpdate", "PasswordHash", "PasswordSalt" },
                values: new object[] { new DateTime(2022, 1, 21, 22, 53, 31, 496, DateTimeKind.Local).AddTicks(6952), new DateTime(2022, 1, 21, 22, 53, 31, 497, DateTimeKind.Local).AddTicks(8791), new byte[] { 42, 33, 59, 80, 135, 34, 41, 212, 124, 11, 64, 161, 70, 137, 134, 195, 32, 32, 32, 209, 115, 193, 69, 33, 138, 70, 34, 159, 213, 112, 250, 231, 233, 228, 115, 185, 58, 13, 214, 135, 152, 73, 14, 126, 111, 158, 58, 241, 26, 173, 186, 231, 210, 81, 120, 162, 130, 33, 238, 192, 118, 119, 124, 4 }, new byte[] { 203, 21, 121, 159, 203, 65, 121, 72, 64, 29, 203, 34, 156, 249, 249, 196, 45, 51, 57, 65, 54, 237, 204, 119, 127, 187, 104, 84, 79, 165, 78, 79, 73, 167, 35, 45, 100, 195, 170, 226, 0, 191, 144, 82, 126, 74, 197, 197, 136, 186, 75, 162, 182, 243, 93, 247, 6, 191, 232, 42, 222, 105, 127, 188, 189, 157, 232, 96, 119, 106, 201, 172, 251, 130, 22, 132, 112, 36, 42, 24, 78, 90, 31, 66, 237, 146, 213, 165, 70, 248, 103, 124, 125, 40, 135, 179, 23, 167, 30, 152, 79, 100, 113, 231, 187, 9, 141, 151, 248, 180, 126, 219, 175, 178, 3, 76, 46, 198, 155, 11, 155, 45, 175, 92, 122, 104, 42, 94 } });
        }
    }
}
