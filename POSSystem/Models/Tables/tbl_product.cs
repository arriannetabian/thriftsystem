using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace POSSystem.Models.Tables
{
    public class tbl_product
    {
        public int productID { get; set; }
        public int categoryID { get; set; }
        public string product_name { get; set; }
        public string product_desc { get; set; }
        public string size { get; set; }
        public string color { get; set; }
        public string condition_status { get; set; }
        public decimal price { get; set; }
        public string product_status { get; set; }
        public DateTime? createdAt { get; set; }
        public DateTime? updatedAt { get; set; }
    }
}