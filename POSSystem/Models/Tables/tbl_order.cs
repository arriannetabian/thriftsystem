using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace POSSystem.Models.Tables
{
    public class tbl_order
    {
        public int orderID { get; set; }
        public int userID { get; set; }
        public DateTime? order_date { get; set; }
        public decimal total_amount { get; set; }
        public string order_status { get; set; }
        public DateTime? createdAt { get; set; }
        public DateTime? updatedAt { get; set; }
    }

    public class tbl_order_item
    {
        public int orderItemID { get; set; }
        public int orderID { get; set; }
        public int productID { get; set; }
        public int quantity { get; set; }
        public decimal price { get; set; }
        public decimal subtotal { get; set; }
        public DateTime? createdAt { get; set; }
        public DateTime? updatedAt { get; set; }
    }

}