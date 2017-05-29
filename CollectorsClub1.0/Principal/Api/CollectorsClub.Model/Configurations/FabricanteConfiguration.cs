
using System.ComponentModel.DataAnnotations.Schema;
using CollectorsClub.Model.Entities;

using System.Data.Entity.ModelConfiguration;
using System.Linq;
using System.Text;
namespace CollectorsClub.Model.Configurations {
	public partial class FabricanteConfiguration : EntityTypeConfiguration<Fabricante> {
		public FabricanteConfiguration() {
			ToTable("Fabricantes");
			HasKey(p => new { p.Id });
			HasRequired(p => p.Marca).WithMany(p => p.Fabricantes).HasForeignKey(p => new { p.IdMarca });
			Property(p => p.Id).IsRequired();
			Property(p => p.Nombre).IsRequired().HasMaxLength(50);
			Property(p => p.Codigo).IsRequired().HasMaxLength(50);
			Property(p => p.IdMarca).IsRequired().HasMaxLength(3);
		}
	}
}