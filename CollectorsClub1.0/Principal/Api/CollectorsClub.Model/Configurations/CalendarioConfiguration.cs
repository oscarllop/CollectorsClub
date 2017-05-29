
using System.ComponentModel.DataAnnotations.Schema;
using CollectorsClub.Model.Entities;

using System.Data.Entity.ModelConfiguration;
using System.Linq;
using System.Text;
namespace CollectorsClub.Model.Configurations {
	public partial class CalendarioConfiguration : EntityTypeConfiguration<Calendario> {
		public CalendarioConfiguration() {
			ToTable("Calendarios");
			HasKey(p => new { p.Id });
			HasRequired(p => p.Entidad).WithMany(p => p.CalendariosPorEntidad).HasForeignKey(p => new { p.IdEntidad });
			HasOptional(p => p.EntidadContratante).WithMany(p => p.CalendariosPorEntidadContratante).HasForeignKey(p => new { p.IdEntidadContratante });
			HasOptional(p => p.Estado).WithMany(p => p.Calendarios).HasForeignKey(p => new { p.IdEstado });
			HasOptional(p => p.Fabricante).WithMany(p => p.Calendarios).HasForeignKey(p => new { p.IdFabricante });
			HasRequired(p => p.TipoColeccionCalendario).WithMany(p => p.Calendarios).HasForeignKey(p => new { p.IdTipoColeccion });
			HasRequired(p => p.Categoria).WithMany(p => p.Calendarios).HasForeignKey(p => new { p.IdCategoria });
			HasRequired(p => p.Subcategoria).WithMany(p => p.Calendarios).HasForeignKey(p => new { p.IdSubcategoria });
			HasRequired(p => p.Usuario).WithMany(p => p.Calendarios).HasForeignKey(p => new { p.IdUsuario });
			HasRequired(p => p.Marca).WithMany(p => p.Calendarios).HasForeignKey(p => new { p.IdMarca });
			Property(p => p.Id).IsRequired();
			Property(p => p.Nombre).IsRequired().HasMaxLength(50);
			Property(p => p.IdTipoColeccion).IsRequired();
			Property(p => p.IdCategoria).IsRequired();
			Property(p => p.IdSubcategoria).IsRequired();
			Property(p => p.Codigo).IsRequired().HasMaxLength(50);
			Property(p => p.Anyo).HasMaxLength(50);
			Property(p => p.Serie).HasMaxLength(50);
			Property(p => p.IdEntidad).IsRequired();
			
			Property(p => p.NumeroSerie).HasMaxLength(50);
			
			Property(p => p.DL).HasMaxLength(50);
			
			Property(p => p.Variante).HasMaxLength(50);
			
			Property(p => p.PaginaWeb).HasMaxLength(100);
			Property(p => p.IdUsuario).IsRequired();
			Property(p => p.Imagen).HasMaxLength(250);
			Property(p => p.ImagenEnBinario).HasMaxLength(2147483647);
			Property(p => p.Visible).IsRequired();
			Property(p => p.IdMarca).IsRequired().HasMaxLength(3);
		}
	}
}