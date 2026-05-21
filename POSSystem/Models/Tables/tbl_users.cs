using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace POSSystem.Models.Tables
{
    public class tbl_user
    {
        public int userID { get; set; }
        public int roleID { get; set; }
        public string full_name { get; set; }
        public string email { get; set; }
        public string contact_number { get; set; }
        public string username { get; set; }
        public string password { get; set; }
        public string status { get; set; }
        public DateTime? createdAt { get; set; }
        public DateTime? updatedAt { get; set; }
    }
}