using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace POSSystem.Models.Tables
{
    public class tbl_stock
    {
        public int stockID { get; set; }
        public int productID { get; set; }
        public int quantity { get; set; }
        public string stock_status { get; set; }
        public DateTime? createdAt { get; set; }
        public DateTime? updatedAt { get; set; }
    }
}