using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;

namespace apiplate.Extensions
{
    public static class DbUpdateExceptionDecoder
    {
        public static string Decode(this DbUpdateException exception)
        {
            var sqlException = exception.InnerException as SqlException;
            if (sqlException != null)
            {
                switch (sqlException.Number)
                {
                    case 2601:
                        return "This item is already exist in database";
                    default:
                        return "Error Ocurred While updating the database !";
                }

            }
            else
            {
                return "Error Ocurred While updating the database !";
            }
        }
    }
}