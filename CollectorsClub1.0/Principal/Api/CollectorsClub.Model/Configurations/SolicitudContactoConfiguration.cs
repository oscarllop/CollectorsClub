
using System.ComponentModel.DataAnnotations.Schema;
using CollectorsClub.Model.Entities;

using System.Data.Entity.ModelConfiguration;
using System.Linq;
using System.Text;
namespace CollectorsClub.Model.Configurations {
	public partial class SolicitudContactoConfiguration : EntityTypeConfiguration<SolicitudContacto> {
		public SolicitudContactoConfiguration() {
			ToTable("SolicitudesContacto");
			HasKey(p => new { p.Id });
			HasRequired(p => p.Marca).WithMany(p => p.SolicitudesContacto).HasForeignKey(p => new { p.IdMarca });
			Property(p => p.Id).IsRequired();
			Property(p => p.Nombre).IsRequired().HasMaxLength(150);
			Property(p => p.CorreoElectronico).IsRequired().HasMaxLength(150);
			Property(p => p.Asunto).IsRequired().HasMaxLength(150);
			Property(p => p.Contenido).IsRequired().HasMaxLength(2147483647);
			Property(p => p.FechaAlta).IsRequired();
			
			Property(p => p.IdMarca).IsRequired().HasMaxLength(3);
		}
	}
}