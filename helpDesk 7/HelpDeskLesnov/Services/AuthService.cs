using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HelpDeskLesnov.Services
{

    public class AuthService
    {

        public bool CheckCredentials(string login, string password)
        {
            return login == "admin" && password == "12345";
        }
    }
}
