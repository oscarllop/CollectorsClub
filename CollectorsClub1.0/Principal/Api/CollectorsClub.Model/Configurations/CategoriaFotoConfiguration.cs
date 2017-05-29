
using System.ComponentModel.DataAnnotations.Schema;
using CollectorsClub.Model.Entities;

using System.Data.Entity.ModelConfiguration;
using System.Linq;
using System.Text;
namespace CollectorsClub.Model.Configurations {
	public partial class CategoriaFotoConfiguration : EntityTypeConfiguration<CategoriaFoto> {
		public CategoriaFotoConfiguration() {
			ToTable("CategoriasFotos");
			HasKey(p => new { p.Id });
			HasRequired(p => p.Marca).WithMany(p => p.CategoriasFotos).HasForeignKey(p => new { p.IdMarca });
			Property(p => p.Id).IsRequired();
			Property(p => p.FechaAlta).IsRequired();
			
			Property(p => p.Activa).IsRequired();
			Property(p => p.Orden).IsRequired();
			Property(p => p.Nombre).IsRequired().HasMaxLength(150);
			Property(p => p.IdMarca).IsRequired().HasMaxLength(3);
		}
	}
}