using POSSystem.Models.Tables;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.ModelConfiguration;
using System.Linq;
using System.Web;

namespace POSSystem.Models.Maps
{
    public class product_maps : EntityTypeConfiguration<tbl_product>
    {
        public product_maps()
        {
            HasKey(x => x.productID);
            ToTable("tbl_product");

      
        }
    }
}