
using System.ComponentModel.DataAnnotations.Schema;
using CollectorsClub.Model.Entities;

using System.Data.Entity.ModelConfiguration;
using System.Linq;
using System.Text;
namespace CollectorsClub.Model.Configurations {
	public partial class EventoConfiguration : EntityTypeConfiguration<Evento> {
		public EventoConfiguration() {
			ToTable("Eventos");
			HasKey(p => new { p.Id });
			HasRequired(p => p.Marca).WithMany(p => p.Eventos).HasForeignKey(p => new { p.IdMarca });
			HasRequired(p => p.Tipo).WithMany(p => p.Eventos).HasForeignKey(p => new { p.IdTipo });
			Property(p => p.Id).IsRequired();
			Property(p => p.FechaAlta).IsRequired();
			
			Property(p => p.Fecha).IsRequired();
			Property(p => p.HoraInicio).IsRequired();
			Property(p => p.HoraFin).IsRequired();
			Property(p => p.IdTipo).IsRequired();
			Property(p => p.Activa).IsRequired();
			Property(p => p.IdMarca).IsRequired().HasMaxLength(3);
			Property(p => p.Nombre).IsRequired().HasMaxLength(750);
			Property(p => p.Descripcion).HasMaxLength(2147483647);
			Property(p => p.Ubicacion).IsRequired().HasMaxLength(500);
		}
	}
}