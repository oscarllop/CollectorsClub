<%@ Control Language="C#" AutoEventWireup="false" Inherits="CollectorsClub.UI.Skins.Controls.BoletinReducido" CodeFile="BoletinReducido.ascx.cs" %>
<div>
	<h4>
		<span class="Head">Newsletter</span>
	</h4>
	<div>
		<div>
			<div class="Normal">
				<p>Introduce aquí tu e-mail y regístrate a nuestro boletín.</p>

				<div class="alert alert-success hidden" id="newsletterSuccess"><strong>Felicidades!</strong> Te has suscrito correctaente.</div>

				<div class="alert alert-danger hidden" id="newsletterError">&nbsp;</div>

				<div class="newsletter">
					<div class="input-group">
						<input class="form-control" id="email" name="email" placeholder="Dirección de correo" type="text" />
						<span class="input-group-btn">
							<button class="btn btn-default" type="submit">Enviar</button>
						</span></div>
				</div>
			</div>
		</div>
	</div>
	<div class="clearfix">
	</div>
</div>

