using POSSystem.Models.Tables;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.ModelConfiguration;
using System.Linq;
using System.Web;

namespace POSSystem.Models.Maps
{
    public class payment_maps : EntityTypeConfiguration<tbl_payment>
    {
        public payment_maps()
        {
            HasKey(x => x.paymentID);
            ToTable("tbl_payment");

     
        }
    }
}