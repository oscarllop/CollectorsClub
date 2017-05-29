
using System.ComponentModel.DataAnnotations.Schema;
using CollectorsClub.Model.Entities;

using System.Data.Entity.ModelConfiguration;
using System.Linq;
using System.Text;
namespace CollectorsClub.Model.Configurations {
	public partial class SubcategoriaCalendarioConfiguration : EntityTypeConfiguration<SubcategoriaCalendario> {
		public SubcategoriaCalendarioConfiguration() {
			ToTable("SubcategoriasCalendario");
			HasKey(p => new { p.Id });
			HasRequired(p => p.Marca).WithMany(p => p.SubcategoriasCalendario).HasForeignKey(p => new { p.IdMarca });
			HasRequired(p => p.Categoria).WithMany(p => p.Subcategorias).HasForeignKey(p => new { p.IdCategoria });
			Property(p => p.Id).IsRequired();
			Property(p => p.Nombre).IsRequired().HasMaxLength(50);
			Property(p => p.Codigo).IsRequired().HasMaxLength(50);
			Property(p => p.IdMarca).IsRequired().HasMaxLength(3);
			Property(p => p.IdCategoria).IsRequired();
		}
	}
}