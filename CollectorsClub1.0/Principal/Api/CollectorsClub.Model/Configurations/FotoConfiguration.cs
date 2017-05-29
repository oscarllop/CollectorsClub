
using System.ComponentModel.DataAnnotations.Schema;
using CollectorsClub.Model.Entities;

using System.Data.Entity.ModelConfiguration;
using System.Linq;
using System.Text;
namespace CollectorsClub.Model.Configurations {
	public partial class FotoConfiguration : EntityTypeConfiguration<Foto> {
		public FotoConfiguration() {
			ToTable("Fotos");
			HasKey(p => new { p.Id });
			HasRequired(p => p.Categoria).WithMany(p => p.Fotos).HasForeignKey(p => new { p.IdCategoria });
			HasRequired(p => p.Marca).WithMany(p => p.Fotos).HasForeignKey(p => new { p.IdMarca });
			Property(p => p.Id).IsRequired();
			Property(p => p.FechaAlta).IsRequired();
			
			Property(p => p.NombreArchivoImagen).IsRequired().HasMaxLength(150);
			Property(p => p.Orden).IsRequired();
			Property(p => p.Activa).IsRequired();
			Property(p => p.IdCategoria).IsRequired();
			Property(p => p.Nombre).IsRequired().HasMaxLength(750);
			Property(p => p.Descripcion).IsRequired().HasMaxLength(2147483647);
			Property(p => p.IdMarca).IsRequired().HasMaxLength(3);
		}
	}
}