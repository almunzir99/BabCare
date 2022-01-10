using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using apiplate.Domain.Models;
using apiplate.Resources;
using Microsoft.IdentityModel.Tokens;

namespace apiplate.Helpers
{
    public class JwtHelper
    {
       public static string GenerateToken(BasicUserInformationResource identity, string identityType, string secretKey, RoleResource role = default)
        {
            var claims = new List<Claim>{
                new Claim("id",identity.Id.ToString()),
                new Claim(ClaimTypes.Email,identity.Email),
                new Claim(ClaimTypes.Role,identityType),
            };
            if(identityType == "ADMIN")
            {
                var admin = identity as AdminResource;
                if(role == default)
                    claims.Add(new Claim("Manager","true"));
                else
                    claims.Add(new Claim("admin_role",role.Title));
                if(admin.IsManager == true)
                    claims.Add(new Claim("type","manager"));
                else
                    claims.Add(new Claim("type","admin"));

                

            }
            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes(secretKey);
            var descriptor = new SecurityTokenDescriptor()
            {
                Subject = new ClaimsIdentity(claims),
                SigningCredentials = new SigningCredentials(
                    new SymmetricSecurityKey(key),
                    SecurityAlgorithms.HmacSha256Signature),
                Expires = DateTime.UtcNow.AddMonths(12),
            };
            var token = tokenHandler.CreateToken(descriptor);
            return tokenHandler.WriteToken(token);
        }
    }
}