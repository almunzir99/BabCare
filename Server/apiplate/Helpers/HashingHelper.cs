using System;

namespace apiplate.Helpers
{
    public class HashingHelper
    {
        public static void CreateHashPassword(string password, out byte[] passowordHash, out byte[] passwordSalt)
        {
            if (password == null)
                throw new ArgumentNullException("password");
            if (string.IsNullOrWhiteSpace(password))
                throw new ArgumentNullException("Password cannot be empty or white space", "password");
            using (var hmac = new System.Security.Cryptography.HMACSHA512())
            {
                passwordSalt = hmac.Key;
                passowordHash = hmac.ComputeHash(System.Text.Encoding.ASCII.GetBytes(password));
            }

        }
        public static Boolean VerifyPassword(string password, byte[] storedHash, byte[] storedSalt)
        {
            if (password == null)
                throw new ArgumentNullException("Password");
            if (string.IsNullOrWhiteSpace(password))
                throw new ArgumentNullException("Password cannot be empty or white space", "password");
            if (storedHash.Length != 64)
                throw new ArgumentException("Invalid length of password hash (64 bytes expected) ", "passwordHash");
            if (storedSalt.Length != 128)
                throw new ArgumentException("Invalid length of password salt (64 bytes expected) ", "passwordHash");
            using (var hmac = new System.Security.Cryptography.HMACSHA512(storedSalt))
            {
                var computedHash = hmac.ComputeHash(System.Text.Encoding.ASCII.GetBytes(password));
                for (int i = 0; i < storedHash.Length; i++)
                {
                    if (computedHash[i] != storedHash[i])
                        return false;
                }
                return true;

            }
        }
    }
}