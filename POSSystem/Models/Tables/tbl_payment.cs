using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace POSSystem.Models.Tables
{
    public class tbl_payment
    {
        public int paymentID { get; set; }
        public int orderID { get; set; }
        public string payment_method { get; set; }
        public decimal payment_amount { get; set; }
        public int payment_status { get; set; }
        public DateTime? payment_date { get; set; }
        public DateTime? createdAt { get; set; }
        public DateTime? updatedAt { get; set; }
    }
}